%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PESTI Report Class File 
%
% Adapted to PESTI/ISEP style (April/2024) by 
%  Elsa Ferreira Gomes (efg@isep.ipp.pt) and 
%  Jorge Coelho (jmn@isep.ipp.pt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TMDEI Thesis Class File
% 
% Based on MastersDoctoralThesis Version 1.2 by Vel (vel@latextemplates.com) and
% Johannes Böttcher, downloaded from (21/11/15):
% http://www.LaTeXTemplates.com
%
% Authors:
%  Vel (vel@latextemplates.com)
%  Johannes Böttcher
%
% Adapted to TMDEI/ISEP style (Dec/2015) by 
%  Nuno Pereira (nap@isep.ipp.pt) and 
%  Paulo Baltarejo (pbs@isep.ipp.pt)
%
% Notes:
% 1) This class file defines the structure and layout of the template file (main.tex).
% 2) It has been written in such a way that under most circumstances you 
% should not need to edit it.
%
% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS DEFINITION AND PARAMETERS
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\newcommand{\classname}{tmdei-style}
\ProvidesClass{\classname}
\providecommand{\baseclass}{book}

\RequirePackage{etoolbox}
\RequirePackage{xparse}
\newbool{nolistspace}
\newbool{listtoc}
\newbool{toctoc}
\newbool{parskip}
\newbool{hyperrefsupport}
\booltrue{hyperrefsupport}
\newbool{hyperreflinkcolor}
\booltrue{hyperreflinkcolor}
\newbool{headsepline}

\DeclareOption{nohyperref}{\boolfalse{hyperrefsupport}}
\DeclareOption{nohyperreflinkcolor}{\boolfalse{hyperreflinkcolor}}
\DeclareOption{nolistspacing}{\booltrue{nolistspace}}
\DeclareOption{liststotoc}{\booltrue{listtoc}}
\DeclareOption{toctotoc}{\booltrue{toctoc}}
\DeclareOption{parskip}{\booltrue{parskip}}
\DeclareOption{headsepline}{\booltrue{headsepline}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}

\ProcessOptions\relax

\LoadClass{\baseclass}

%----------------------------------------------------------------------------------------
%	CLASS OPTIONS
%----------------------------------------------------------------------------------------
\ifbool{parskip}{\RequirePackage{parskip}} % If the parskip option is passed to the class, require the parskip package 

\patchcmd{\@makechapterhead}{\vspace*{50\p@}}{\abovechapterspace}{}{}
\patchcmd{\@makeschapterhead}{\vspace*{50\p@}}{\abovechapterspace}{}{}
\newcommand{\abovechapterspace}{\vspace*{50pt}}

\ifbool{listtoc}{% If the liststotoc option has been passed to the class, add the lists to the table of contents
	\patchcmd{\listoftables}{\@starttoc{lot}}{%
		\addchaptertocentry{\listtablename}\@starttoc{lot}}{}{}%
	\patchcmd{\listoffigures}{\@starttoc{lof}}{%
		\addchaptertocentry{\listfigurename}\@starttoc{lof}}{}{}%
}

\ifbool{toctoc}{% If the toctotoc options has been passed to the class, add the table of contents to the table of contents
	\patchcmd{\tableofcontents}{\@starttoc{toc}}{%
		\addchaptertocentry{\contentsname}\@starttoc{toc}}{}{}%
}

\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}

% If the option `nolistspacing' is given, the spacing in the different lists is reduced to single spacing. This option is only useful, if the spacing of the document has been changed to onehalfspacing or doublespacing.
\ifbool{nolistspace}{
	\patchcmd{\listoffigures}{%
		\@starttoc{lof}}{%
			\begingroup%
			\singlespace\@starttoc{lof}\endgroup%
		}{}{}%
	\patchcmd{\listoftables}{%
		\@starttoc{lot}}{%
			\begingroup%
			\singlespace\@starttoc{lot}\endgroup%
		}{}{}%
	\patchcmd{\tableofcontents}{%
		\@starttoc{toc}}{%
			\begingroup%
			\singlespace\@starttoc{toc}\endgroup%
		}{}{}%
}{}

% Addchap provides unnumbered chapters with an entry in the table of contents as well as an updated header
\ProvideDocumentCommand{\addchap}{ s o m }{%
	\chapter*{#3}%
	\markboth{}{}%
	\IfBooleanTF{#1}{%
	}{%
		\IfNoValueTF{#2}{%
			\addchaptertocentry{#3}%
			\markboth{\MakeMarkcase{#3}}{\MakeMarkcase{#3}}%
		}{%
			\addchaptertocentry{#2}%
			\markboth{\MakeMarkcase{#2}}{\MakeMarkcase{#2}}%
		}%
	}%
}%

\ProvideDocumentCommand{\addsec}{ s o m }{%
	\section*{#3}%
	\markright{}%
	\IfBooleanTF{#1}{%
	}{%
		\IfNoValueTF{#2}{%
			\addcontentsline{toc}{section}{#3}%
			\markright{\MakeMarkcase{#3}}%%
		}{%
			\addcontentsline{toc}{section}{#2}%
			\markright{\MakeMarkcase{#2}}%
		}%
	}%
}%

%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage{babel} % Required for automatically changing names of document elements to languages besides english

\RequirePackage{scrbase} % Required for handling language-dependent names of sections/document elements

\RequirePackage{scrhack} % Loads fixes for various packages

\RequirePackage{setspace} % Required for changing line spacing

\RequirePackage{longtable} % Required for tables that span multiple pages (used in the symbols, abbreviations and physical constants pages)

\RequirePackage{siunitx} % Required for \SI commands

\RequirePackage{graphicx} % Required to include images
\graphicspath{{.}}

\RequirePackage[dvipsnames]{xcolor} % Required for extra color names

\RequirePackage{booktabs} % Required for better table rules

\RequirePackage[utf8]{inputenc} % Required for inputting portuguese characters
\RequirePackage[T1]{fontenc} % Output font encoding for portuguese characters
\RequirePackage{lmodern} % use the Latin Modern fonts to avoid "blurring"

\RequirePackage[autostyle=true]{csquotes} % Required to generate language-dependent quotes in the bibliography

\RequirePackage{cmbright} % Default font: CM Bright, lighter sans-serif variant of Computer Modern Sans Serif 

\RequirePackage[chapter]{algorithm} % Required for Algorithms
\RequirePackage{algpseudocode} % Part algorithmicx package, required to customize the layout of algorithms.

\RequirePackage{listings} % Required for code listings
\lstset{ %
  backgroundcolor=\color{white},   % choose the background color; 
  basicstyle=\footnotesize,        % the size of the fonts that are used for the code
  breakatwhitespace=false,         % sets if automatic breaks should only happen at whitespace
  breaklines=true,                 % sets automatic line breaking
  captionpos=b,                    % sets the caption-position to bottom
  commentstyle=\color{green},    % comment style
  deletekeywords={...},            % if you want to delete keywords from the given language
  escapeinside={\%*}{*)},          % if you want to add LaTeX within your code
  extendedchars=true,              % lets you use non-ASCII characters; for 8-bits encodings only, does not work with UTF-8
  frame=single,	                   % adds a frame around the code
  keepspaces=true,                 % keeps spaces in text, useful for keeping indentation of code 
  keywordstyle=\color{blue},       % keyword style
  language=Java,                 % the default language of the code
  otherkeywords={*,...},           % if you want to add more keywords to the set
  numbers=left,                    % where to put the line-numbers; possible values are (none, left, right)
  numbersep=5pt,                   % how far the line-numbers are from the code
  numberstyle=\tiny\color{gray}, % the style that is used for the line-numbers
  rulecolor=\color{black},         % if not set, the frame-color may be changed on line-breaks within not-black text
  showspaces=false,                % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'
  showstringspaces=false,          % underline spaces within strings only
  showtabs=false,                  % show tabs within strings adding particular underscores
  stepnumber=1,                    % the step between two line-numbers. If it's 1, each line will be numbered
  stringstyle=\color{MidnightBlue},     % string literal style
  tabsize=2,	                   % sets default tabsize to 2 spaces
  title=\lstname                   % show the filename of files included with \lstinputlisting; also try caption instead of title
}

\renewcommand{\lstlistingname}{Listagem}

\RequirePackage[acronym,nonumberlist,toc]{glossaries} %Required to define acronyms and make glossaries

\RequirePackage[centerlast,small,sc]{caption} % Required for customising the captions
\setlength{\captionmargin}{50pt}

%----------------------------------------------------------------------------------------

\newcommand{\checktoopen}{% New command to move content to the next page which prints to the next odd page if twosided mode is active  
\if@openright\cleardoublepage\else\clearpage\fi
}

\newcommand\bhrule{\typeout{--------------------}}
\newcommand\tttypeout[1]{\bhrule\typeout{\space #1}\bhrule}

\newcommand{\HRule}{\rule{\linewidth}{0.5mm}} % New command to make the lines in the title page
\newcommand{\decoRule}{\rule{.8\textwidth}{.4pt}} % New command for a rule to be used under figures

\renewcommand{\abovechapterspace}{\vspace*{10pt}} % Reduce the whitespace above a chapter heading

\setcounter{tocdepth}{3} % The depth to which the document sections are printed to the table of contents
\providecommand\addchaptertocentry[1]{%
\ifdef{\phantomsection}{\phantomsection}{}% The \phantomsection command is necessary for hyperref to jump to the correct page
\addcontentsline{toc}{chapter}{#1}%
}

%----------------------------------------------------------------------------------------
%	MARGINS
%----------------------------------------------------------------------------------------

\RequirePackage{geometry}
\geometry{
	head=13.7pt,
	paper=a4paper, % Change to letterpaper for US letter
	inner=3.5cm, % Inner margin
	outer=2.6cm, % Outer margin
	%bindingoffset=2cm, % Binding offset
	top=3.5cm, % Top margin
	bottom=2.5cm, % Bottom margin	
}

\raggedbottom

%----------------------------------------------------------------------------------------
%	PENALTIES
%----------------------------------------------------------------------------------------

\doublehyphendemerits=10000 % No consecutive line hyphens
\brokenpenalty=10000 % No broken words across columns/pages
\widowpenalty=9999 % Almost no widows at bottom of page
\clubpenalty=9999 % Almost no orphans at top of page
\interfootnotelinepenalty=9999 % Almost never break footnotes

%----------------------------------------------------------------------------------------
%	HEADERS AND FOOTERS
%----------------------------------------------------------------------------------------

\RequirePackage[markcase=used]{scrlayer-scrpage}
\providepairofpagestyles{thesisSimple}{%
\clearpairofpagestyles%
\automark[chapter]{chapter}
\ihead{\headmark}% Inner header
\ohead[\pagemark]{\pagemark}% Outer header
}
\ifoot{}% Inner footer
\ofoot{}% Outer footer
\pagestyle{thesisSimple}
\providepairofpagestyles[thesisSimple]{thesis}{%
\automark*[section]{}%
}
\providepairofpagestyles[thesisSimple]{review}{%
	\ofoot[\ttitle/\authorname]{\ttitle/\authorname}
	\ifoot[\today]{\today}
}
\pagestyle{thesis}
\ifbool{headsepline}{\KOMAoption{headsepline}{true}}{}
\PreventPackageFromLoading[\ClassError{\classname}{Package `fancyhdr' is
incompatible\MessageBreak with this class}{The pagesyles are defined 
using package `scrlayer-scrpage', please consult the\MessageBreak 
KOMA-script documentation for details.}]{fancyhdr}


\newcommand{\blank@p@gestyle}{empty}
\newcommand{\blankpagestyle}[1]{\def\blank@p@gestyle{#1}}

\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\thispagestyle{\blank@p@gestyle}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}

%----------------------------------------------------------------------------------------
%	DEFINE CUSTOM THESIS INFORMATION COMMANDS
%----------------------------------------------------------------------------------------

\def\authorname{}
\def\ttitle{}
\newcommand*{\supervisor}[1]{\def\supname{#1}}
\newcommand*{\cosupervisor}[1]{\def\cosupname{#1}}
\newcommand*{\thesistitle}[1]{\def\@title{#1}\def\ttitle{#1}}
\newcommand*{\thesissubtitle}[1]{\def\tsubtitle{#1}}
\newcommand*{\subjectarea}[1]{\def\subjectname{#1}}
\newcommand*{\committeepresident}[1]{\def\presidentname{#1}}
\newcommand*{\committeemembers}[1]{\def\committee{#1}}
\newcommand*{\thesisdate}[1]{\def\tdate{#1}}
\newcommand*{\monthyear}[1]{\def\myear{#1}}
\renewcommand*{\author}[1]{\def\authorname{#1}}
\newcommand*{\university}[1]{\def\univname{#1}}
\newcommand*{\department}[1]{\def\deptname{#1}}
\newcommand*{\keywords}[1]{\def\keywordnames{#1}}

%----------------------------------------------------------------------------------------
%	TITLEPAGE PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\dissertationdisclamer}{A dissertation submitted in partial fulfilment of the \\ requirements for the degree of Master of Science, Area of}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\dissertationdisclamer}{A dissertation submitted in partial fulfillment of \\ the requirements for the degree of Master of Science, Specialisation Area of}
\providecaptionname{portuguese}{\dissertationdisclamer}{Relatório de Projeto/Estágio da Licenciatura em \\ Engenharia Inform\'atica.\\} % Portuguese 
\newcommand{\supervisorlabel}{Supervisor}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\supervisorlabel}{Supervisor}
\providecaptionname{portuguese}{\supervisorlabel}{Orientador ISEP}
\newcommand{\cosupervisorlabel}{Co-Supervisor}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\cosupervisorlabel}{Co-Supervisor}
\providecaptionname{portuguese}{\cosupervisorlabel}{Supervisor Externo}




\newcommand{\evallabel}{Evaluation Committee}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\evallabel}{Evaluation Committee}
\providecaptionname{portuguese}{\evallabel}{J\'uri}
\newcommand{\presidentlabel}{President}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\presidentlabel}{President}
\providecaptionname{portuguese}{\presidentlabel}{Presidente}
\newcommand{\memberslabel}{Members}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\memberslabel}{Members}
\providecaptionname{portuguese}{\memberslabel}{Vogais}


\newcommand{\maketitlepage}{
	\checktoopen
	\begin{titlepage}
	{\centering \includegraphics[width=2.5in]{/frontmatter/assets/logo_dei.pdf} \\}
	\null\vfill
	\begin{center}
	{\Huge \bfseries \ttitle}\\ % Thesis title
	\ifdefined\tsubtitle {\bfseries \tsubtitle} \\ \fi % Thesis sub title, if exists
	\vfill
    {\Large \bfseries \tdate}\\
	\vfill
	{\bfseries \authorname}\\
	\vfill
	%{\Large \bfseries \dissertationdisclamer~\subjectname}
	\end{center}
    {\centering \includegraphics[width=2.5in]{/frontmatter/assets/isep_logo.pdf} \\}
	\vfill

	\end{titlepage}

 \begin{titlepage}
	\null\vfill
	\begin{center}
	{\Huge \bfseries \ttitle}\\ % Thesis title
	\ifdefined\tsubtitle {\bfseries \tsubtitle} \\ \fi % Thesis sub title, if exists
	\vfill
    {\Large \bfseries \tdate}\\
	\vfill
	{\bfseries \authorname}\\
	\vfill
	%{\Large \bfseries \dissertationdisclamer~\subjectname}
	
    {\centering \includegraphics[width=2.5in]{/frontmatter/assets/logo_dei.pdf} \\}
	\vfill
    {\Large \bfseries Licenciatura em Engenharia Informática}
    \vfill
    {\large \bfseries \myear}
    \vfill
	{\large \bfseries \noindent \supervisorlabel: \supname } \\
     \vspace{5mm}
	\ifdefined\cosupname {\large \bfseries \cosupervisorlabel: \cosupname} \\ \fi
	\vfill
	% {\normalsize \bfseries \noindent \evallabel} \\
	% {\normalsize \presidentlabel } \\
	% \bigskip
	% {\normalsize \presidentname } \\
	% {\normalsize \memberslabel} \\
	% {\normalsize \committee } \\
    \end{center}

%\thesisdate{Porto, \today} % thesis date,  print it elsewhere with \tdate
	
 
	\end{titlepage}
}


%----------------------------------------------------------------------------------------
%	STATEMENT OF INTEGRITY
%----------------------------------------------------------------------------------------

\newcommand{\statementlabel}{Statement of Integrity}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\statementlabel}{Statement of Integrity}
\providecaptionname{portuguese}{\statementlabel}{Declara\c{c}\~ao de Integridade} % Portuguese

\newcommand{\statementtext}{I hereby declare having conducted this academic work with integrity.\\I have not plagiarised or applied any form of undue use of information or falsification of results along the process leading to its elaboration.\\Therefore the work presented in this document is original and authored by me, having not previously been used for any other end.\\I further declare that I have fully acknowledged the Code of Ethical Conduct of P.PORTO.\\ISEP, \tdate}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\statementtext}{I hereby declare having conducted this academic work with integrity.\\\\I have not plagiarised or applied any form of undue use of information or falsification of results along the process leading to its elaboration.\\\\Therefore the work presented in this document is original and authored by me, having not previously been used for any other end.\\\\I further declare that I have fully acknowledged the Code of Ethical Conduct of P.PORTO.\\\\ISEP, \tdate}
\providecaptionname{portuguese}{\statementtext}{Declaro ter conduzido este trabalho acad\'emico com integridade.\\\\N\~{a}o plagiei ou apliquei qualquer forma de uso indevido de informa\c{c}\~{o}es ou falsifica\c{c}\~{a}o de resultados ao longo do processo que levou \`{a} sua elabora\c{c}\~{a}o.\\\\Portanto, o trabalho apresentado neste documento \'{e} original e de minha autoria, n\~{a}o tendo sido utilizado anteriormente para nenhum outro fim.\\\\Declaro ainda que tenho pleno conhecimento do C\'{o}digo de Conduta \'{E}tica do P.PORTO.\\\\ISEP, \tdate} % Portuguese

\newenvironment{integritystatement}{
	\checktoopen
	\tttypeout{\statementlabel}
	\thispagestyle{plain}
	\chapter*{\statementlabel}
	\statementtext
}
{
  \vfil\vfil\vfil\null
}

%----------------------------------------------------------------------------------------
%	DEDICATION PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\dedicationlabel}{Dedicatory}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\dedicationlabel}{Dedicatory}
\providecaptionname{portuguese}{\dedicationlabel}{Dedicat\'oria} % Portuguese 

\newenvironment{dedicatory}{
	\checktoopen
	\tttypeout{\dedicationlabel}
	\thispagestyle{plain}
	\chapter*{\dedicationlabel}
}
{
  \vfil\vfil\vfil\null
}
    
%----------------------------------------------------------------------------------------
%	ABSTRACT PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\abslabel}{Abstract}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\abslabel}{Abstract}
\providecaptionname{portuguese}{\abslabel}{Resumo} % Portuguese 
\newcommand{\keywordslabel}{Keywords}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\keywordslabel}{Keywords}
\providecaptionname{portuguese}{\keywordslabel}{Palavras-chave} % Portuguese 
\newenvironment{abstract}{
	\checktoopen
	\tttypeout{\abstractname}
	%\addchaptertocentry{\abstractname} % Add the abstract to the table of contents
	\thispagestyle{plain}
	\chapter*{\abslabel}	
}
{
  \bigskip
  {\bf \keywordslabel:} {\keywordnames}
  \vfil\vfil\vfil\null
}

\newcommand{\abslabelotherlang}{Resumo}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\abslabelotherlang}{Resumo}
\providecaptionname{portuguese}{\abslabelotherlang}{Abstract}  
\newenvironment{abstractotherlanguage}{
	\checktoopen
	\tttypeout{\abslabel}
	%\addchaptertocentry{\abslabelotherlang} % Add the abstract to the table of contents	
	\thispagestyle{plain}
	\chapter*{\abslabelotherlang}
}
{
  \vfil\vfil\vfil\null
}

%----------------------------------------------------------------------------------------
%	ABBREVIATIONS PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\abbrevname}{List of Abbreviations}
\providecaptionname{english,british,american}{\abbrevname}{List of Abbreviations}
\providecaptionname{portuguese}{\abbrevname}{Lista de Abrevia\c{c}\~oes}
\NewDocumentEnvironment{abbreviations}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\abbrevname}}{\addchap*{\abbrevname}}
	\begin{longtable}{#1}
\end{longtable}
\addtocounter{table}{-1} % Don't count this table as one of the document tables
\ifbool{nolistspace}{\endgroup}{}
}

%----------------------------------------------------------------------------------------
%	PHYSICAL CONSTANTS PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\constantsname}{Physical Constants}
\providecaptionname{english,british,american}{\constantsname}{Physical Constants}
\providecaptionname{portuguese}{\constantsname}{Constantes}

\NewDocumentEnvironment{constants}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\constantsname}}{\addchap*{\constantsname}}
	\begin{longtable}{#1}
\end{longtable}
\addtocounter{table}{-1} % Don't count this table as one of the document tables
\ifbool{nolistspace}{\endgroup}{}
}

%----------------------------------------------------------------------------------------
%	SYMBOLS PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\symbolsname}{Symbols}
\providecaptionname{english,british,american}{\symbolsname}{List of Symbols}
\providecaptionname{portuguese}{\symbolsname}{Lista de S\'imbolos}
\NewDocumentEnvironment{symbols}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\symbolsname}}{\addchap*{\symbolsname}}
	\begin{longtable}{#1}
\end{longtable}
\addtocounter{table}{-1} % Don't count this table as one of the document tables
\ifbool{nolistspace}{\endgroup}{}
}


%----------------------------------------------------------------------------------------
%	ACRONYM PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\acronymsname}{List of Acronyms}
\iflanguage{portuguese}{
  \renewcommand{\acronymsname}{Lista de Acrónimos}
}{}

\NewDocumentEnvironment{acronyms}{m}{%
  \chapter*{\acronymsname}
  \addcontentsline{toc}{chapter}{\acronymsname}
  \begin{longtable}{#1}
}{
  \end{longtable}
}

%----------------------------------------------------------------------------------------
%	ACKNOWLEDGEMENT PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\acknowledgementlabel}{Acknowledgement}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish} {\acknowledgementlabel}{Acknowledgement} 
\providecaptionname{portuguese} {\acknowledgementlabel}{Agradecimentos}
\newenvironment{acknowledgements}{
	% \addchaptertocentry{\acknowledgementlabel} % Add the acknowledgements to the table of contents
	\tttypeout{\acknowledgementlabel}
	\null\vfil
	\thispagestyle{plain}
	\chapter*{\acknowledgementlabel}
}
{
  \vfil\vfil\vfil\null
}

%----------------------------------------------------------------------------------------
\ifbool{hyperreflinkcolor}{\newcommand{\hreflinkcolor}{true}}{\newcommand{\hreflinkcolor}{false}}


\ifbool{hyperrefsupport}{% If the nohyperref class option has not been specified
\AfterPackage{biblatex}{ % Load the hyperref package after the biblatex package for compatibility 
\RequirePackage{hyperref} % Required for customising links and the PDF
\hypersetup{pdfpagemode={UseOutlines},
bookmarksopen=true,
bookmarksopenlevel=0,
hypertexnames=false,
colorlinks=\hreflinkcolor, % Set coloring of links
citecolor=CadetBlue, % The color of citations
linkcolor=NavyBlue, % The color of references to document elements (sections, figures, etc)
urlcolor=CadetBlue, % The color of hyperlinks (URLs)
pdfstartview={FitV},
unicode,
breaklinks=true,
}

\pdfstringdefDisableCommands{% If there is an explicit linebreak in a section heading (or anything printed to the pdf-bookmarks), it is replaced by a space
   \let\\\space%
}
}
}{%nothing
}

%----------------------------------------------------------------------------------------

% Define some commands to keep the formatting separated from the content 
\newcommand{\keyword}[1]{\textbf{#1}}
\newcommand{\tabhead}[1]{\textbf{#1}}
\newcommand{\code}[1]{\texttt{#1}}
\newcommand{\file}[1]{\texttt{\bfseries#1}}
\newcommand{\option}[1]{\texttt{\itshape#1}}

%----------------------------------------------------------------------------------------

\endinput
