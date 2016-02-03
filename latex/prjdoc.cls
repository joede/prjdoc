%% ----------------------------------------------------------------------
%% `prjdoc.cls'  (c) 1999-2012  Joerg Desch <joerg.desch@gmail.com>
%% License: GPL v3
%% ----------------------------------------------------------------------
%%
\NeedsTeXFormat{LaTeX2e}[1994/12/01]%
\ProvidesClass{prjdoc}[%
  1999/08/30 v0.1 first implementation%
  2001/05/01 v0.2 minor changes
  2012/11/12 v0.3 new default for DIV value. Added TBD and history.
  2015/11/18 v0.4 use package scrpage2
  2016/02/03 v0.5 replaced scrpage2 with scrlayer-scrpage
]%
% this packages are required in the code of the options.
\RequirePackage{lastpage}%
\RequirePackage{ifthen}%

% -----------------------------------------------------------------------
% internal flags
%
\newboolean{PD@signfield}
\newboolean{PD@isManual}
\newboolean{PD@useEnglish}

% -----------------------------------------------------------------------
% redefinable string constants
%
\newcommand*{\PD@author}{}%
\newcommand*{\PD@company}{}%
\newcommand*{\PD@address}{}%
\newcommand*{\PD@prjname}{***need prjname***}%
\newcommand*{\PD@doctype}{***need doctype***}%
\newcommand*{\PD@revision}{***need revision***}%

% -----------------------------------------------------------------------
% The options of the document class
%
\DeclareOption{signfield}{\setboolean{PD@signfield}{true}}
\DeclareOption{nosignfield}{\setboolean{PD@signfield}{false}}
\DeclareOption{manual}{\setboolean{PD@isManual}{true}}
\DeclareOption{project}{\setboolean{PD@isManual}{false}}
\DeclareOption{english}{\setboolean{PD@useEnglish}{true}}

% pass unknown options to the parent class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}

% -----------------------------------------------------------------------
% setup the defaults and process the options
\ExecuteOptions{signfield,project}
\ProcessOptions\relax

% load the parent class and the remaining styles
\LoadClass[DIV12,headsepline]{scrartcl}
\RequirePackage{ltxtable}%
\RequirePackage{booktabs}%
\RequirePackage{scrlayer-scrpage}%
\RequirePackage{abkuerz}%


% functions to setup the local string constants
\newcommand{\PDauthor}[1]{\renewcommand*{\PD@author}{#1}}%
\newcommand{\PDcompany}[1]{\renewcommand*{\PD@company}{#1}}%
\newcommand{\PDaddress}[1]{\renewcommand*{\PD@address}{#1}}%
\newcommand{\PDprjname}[1]{\renewcommand*{\PD@prjname}{#1}}%
\newcommand{\PDdoctype}[1]{\renewcommand*{\PD@doctype}{#1}}%
\newcommand{\PDrevision}[1]{\renewcommand*{\PD@revision}{#1}}%


% -----------------------------------------------------------------------
% an ISO-style titelpage

\newcommand{\PDtitlepage}%
{%
  \begin{titlepage}%
    \thispagestyle{empty}%
    \setlength{\parindent}{0mm}%
    \setlength{\parskip}{0mm}%
    \vspace*{\stretch{1}}%
    \rule{\linewidth}{1mm}%
    \begin{flushleft}%
      \ifthenelse{\boolean{PD@isManual}}%
        {% -- Title of the manual
          \Huge\textbf{\PD@prjname}\\[5mm]%
          \PD@doctype%
        }%
        {% -- Title of the project documentation
          \ifthenelse{\boolean{PD@useEnglish}}
            {\Huge\textbf{Project ``\PD@prjname{}''}\\[5mm]}%
            {\Huge\textbf{Projekt ``\PD@prjname{}''}\\[5mm]}%
          \PD@doctype%
        }%
    \end{flushleft}%
    \rule{\linewidth}{1mm}%
    \vspace*{\stretch{1}}%
    \begin{center}%
    {\large\textbf{Revision \PD@revision}}\\%          %\RCSRevision
    \today%
    \end{center}%

    \vspace*{\stretch{1}}%
    \begin{center}%
      \ifthenelse{\equal{\PD@company}{}}%
        {%
          {\large{}Copyright \copyright{} \PD@author}%
        }%
        {%
          {\large{}Copyright \copyright{} \PD@company}\\%
          \PD@author%
        }%
    \end{center}%

    \ifthenelse{\equal{\PD@address}{}}%
        {%
          \vspace*{\stretch{3}}%
        }%
        {%
          \vspace*{\stretch{1}}%
          \begin{center}%
            \PD@address{}%
          \end{center}%
          \vspace*{\stretch{2}}%
        }%

    \ifthenelse{\boolean{PD@signfield}}%
    {\begin{tabularx}{\linewidth}{XXX}%
       \toprule%
       \ifthenelse{\boolean{PD@useEnglish}}
          {\PDthead{created:} & \PDthead{checked:} & \PDthead{released:}\\}%
          {\PDthead{Erstellt:} & \PDthead{Gepr\"uft:} & \PDthead{Freigegeben:}\\}%
       \cmidrule(r){1-1}\cmidrule(r){2-2}\cmidrule(r){3-3}%
       &&\\[2cm]%
       \ifthenelse{\boolean{PD@useEnglish}}
         {\footnotesize{name, dpt\@., date}&\footnotesize{name, dpt\@., date}&\footnotesize{name, dpt\@., date}\\}%
         {\footnotesize{Name, Abt\@., Datum}&\footnotesize{Name, Abt\@., Datum}&\footnotesize{Name, Abt\@., Datum}\\}%
       \bottomrule%
     \end{tabularx}%
    }%
    {}%
  \end{titlepage}%
}%



% -----------------------------------------------------------------------
% ISO-style header and footer

\deftripstyle{PDheading}[.4pt]%
  {%
    \ifthenelse{\boolean{PD@isManual}}%
      {% -- Header of the manual
        \PD@doctype{}%
      }%
      {% -- header of the project documentation
        \ifthenelse{\boolean{PD@useEnglish}}
          {\PD@doctype{} Project ``\PD@prjname{}''}%
          {\PD@doctype{} Projekt ``\PD@prjname{}''}%
      }%
  }%
  {%
    \ifthenelse{\boolean{PD@isManual}}%
      {% -- Footer for the manual
        \PD@prjname%
      }{}%
  }{\headmark}% the page header
  {Revision \PD@revision{}%
    \ifthenelse{\equal{\PD@author}{}}%
      {}%
      {, \PD@author{}}%
  }{}%
  {\normalfont\normalsize\thepage{} / \pageref{LastPage}}% The page footer

\renewcommand{\headfont}{\normalfont\slshape\footnotesize}
\renewcommand{\pnumfont}{\normalfont\normalsize}
\pagestyle{PDheading}



% -----------------------------------------------------------------------
% Some code for the table environments

% style for table headers
\newcommand{\PDthead}[1]{\textbf{\footnotesize #1}}


% stolen from Axel Reichert:
%   table captions should be above the table. So we have to redefine
%   the environment to get the right vspaces.
%
\renewenvironment{table}[1][]{%
  \ifthenelse{\equal{#1}{}}{%
    \@float{table}
  }{%
    \@float{table}[#1]%
  }%
  \centering
  \setlength{\@tempdima}{\abovecaptionskip}%
  \setlength{\abovecaptionskip}{\belowcaptionskip}%
  \setlength{\belowcaptionskip}{\@tempdima}%
}{%
  \end@float
}%



% -----------------------------------------------------------------------
% Commands for the definition of `Requests'

% define a environment to number and describe `requests'
%
\newcounter{PD@requestnr} % the global counter
\newenvironment{Requests}%
  {%
    \begin{list}{}%
    {%
      \renewcommand{\makelabel}[1]%
        {%
          \refstepcounter{PD@requestnr}%
          \ifthenelse{\boolean{PD@useEnglish}}
          {\textbf{[R\arabic{PD@requestnr}]}}%
          {\textbf{[A\arabic{PD@requestnr}]}}%
          \ifthenelse{\equal{##1}{}}{}{\label{##1}}%
          \hfill%
        }%
%      \ifthenelse{\equal{#1}{}}%
%        {\setlength{\labelwidth}{5ex}}%
%        {\setlength{\labelwidth}{#1}}%
      \setlength{\labelwidth}{6ex}
      \setlength{\leftmargin}{\labelwidth}%
      \addtolength{\leftmargin}{\labelsep}%
    }%
  }%
  {%
    \end{list}%
  }%

% create a refence to the number of a request. A referenced request
% have no brackets around the `name'.
%
\newcommand{\ReqRef}[1]{%
  \ifthenelse{\boolean{PD@useEnglish}}%
  {\textbf{R\ref{#1}}}%
  {\textbf{A\ref{#1}}}%
}


% -----------------------------------------------------------------------

% internally used command to print a margin note.
%
\newcommand{\PDmarginlabel}[1]%
  {\mbox{}\marginpar{\raggedleft\footnotesize\hspace{0pt}#1}\ignorespaces}

% environment to declare the history of an project.
%
\newenvironment{PDhistory}%
  {%
    \begin{list}{}%
    {%
      % eventuell Datum in Bold oder emph
      \renewcommand{\makelabel}[1]{##1\hfill}%
      \setlength{\labelwidth}{6em}%
      \setlength{\leftmargin}{\labelwidth}%
      \addtolength{\leftmargin}{\labelsep}%
    }%
  }%
  {%
    \end{list}%
  }%

% Declare one entry of an history. The date is passed to this command.
% Optionally, a release string can be passed. This release string is
% shown as margin paragraph.
%
\newcommand{\pdHist}[2][]{%
  \item[#2]%
  \ifthenelse{\equal{#1}{}}{}{\PDmarginlabel{\emph{#1}}}
}%
\newcommand{\pdHistBy}[1]{\textbf{#1:}}%


% -----------------------------------------------------------------------

% Start a sentence with \TBD{} to mark it as a thing that has "to be done"
%
\newcommand{\TBD}{\emph{TBD:}\marginpar{\footnotesize\textbf{TBD}}}%

% -----------------------------------------------------------------------


\endinput
%%
%% End of file `prjdoc.cls'.
