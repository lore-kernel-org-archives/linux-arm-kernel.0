From: Alison_Chaiken@mentor.com (Chaiken, Alison)
Date: Mon, 26 Aug 2013 19:34:10 +0000
Subject: [PATCH] ARM: i.MX6: dts: change iomuxc pinctrl config to match
 Rev. 0 IMX6DQRM
In-Reply-To: <CAHCPf3uSf20CJV4x4K3N0DU-nOmguJPrsEZynhXoeEb0eMnP3Q@mail.gmail.com>
References: <1377495568-9368-1-git-send-email-alison_chaiken@mentor.com>,
 <CAHCPf3uSf20CJV4x4K3N0DU-nOmguJPrsEZynhXoeEb0eMnP3Q@mail.gmail.com>
Message-ID: <60BA5429A0E1584BA3633194F6F993B502E6B62D@NA-MBX-02.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt Sealey [neko at bakuhatsu.net] helpfully inquires:
        Have these been cross-referenced against the same table in Rev 1 of the manual (4/2013)?

I respond: indeed they have been!    The configs in the patch have been checked against the table in the Rev. 1 April manual, which has a different format but not new values.    I absent-mindedly selected an old version of the commit message, sorry.

In addition, the configs have been tested with kernels older than the older release on multiple reference boards from Freescale and Boundary Devices.   Furthermore, many of the changes were ack'ed by Huang Shijie of FSL in, for example,

      http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg32771.html

In April I submitted a related documentation patch

      http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg30583.html

that has fallen by the wayside.   Sorry for failing to include this information in the original posting, but I could not get "git send-email --compose" to behave properly with emacsclient and employer's SMTP.

--
Alison Chaiken
Mentor Embedded Software Division
Fremont, CA USA
alison_chaiken at mentor.com
