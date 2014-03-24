From: eric@eukrea.com (Eric =?UTF-8?B?QsOpbmFyZA==?=)
Date: Mon, 24 Mar 2014 16:41:41 +0100
Subject: [PATCH] ARM: i.MX6: update KSZ9031 phy fixup
In-Reply-To: <1762157698.5689069.1395675049240.JavaMail.zimbra@adeneo-embedded.com>
References: <1395421687-12934-1-git-send-email-hchaumette@adeneo-embedded.com>
 <20140321222320.14370739@e6520eb>
 <1762157698.5689069.1395675049240.JavaMail.zimbra@adeneo-embedded.com>
Message-ID: <20140324164141.51b85f8c@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hubert,

Le Mon, 24 Mar 2014 16:30:49 +0100 (CET),
CHAUMETTE Hubert <hchaumette@adeneo-embedded.com> a ?crit :
> > From: "Eric B?nard" <eric@eukrea.com>
> > that's board specific (the needed delay depends on the routing delay on
> > the PCB), so this should not go in a generic file.
> > 
> > Eric
> > 
> 
> I admit it may need to be in a separate function, but this file already contains
> board-specific fixups (for imx6q sabrelite, Data Modul eDM-QMX6).
> 
true but that's not a reason to add more ;-)

> Anyway, do you have any suggestion for the location I should put it ?
> 
no idea at the moment, I simply used your patch to bring this issue on
the ML as we recently needed to patch the default values for testing
mainline kernel on a custom boards.

Eric
