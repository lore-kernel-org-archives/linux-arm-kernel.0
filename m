From: eric@eukrea.com (Eric =?UTF-8?B?QsOpbmFyZA==?=)
Date: Sat, 28 Feb 2015 21:24:30 +0100
Subject: [PATCH] ARM: mx25: Remove mach-mx25_3ds board file
In-Reply-To: <CAOMZO5Bo=YqCoCQpBRnfROLQTV+wE+wWrmJqUtMGeCaPgT3qiQ@mail.gmail.com>
References: <1425138035-19715-1-git-send-email-festevam@gmail.com>
 <CAOMZO5Bo=YqCoCQpBRnfROLQTV+wE+wWrmJqUtMGeCaPgT3qiQ@mail.gmail.com>
Message-ID: <20150228212430.50f883ab@e6520eb.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Le Sat, 28 Feb 2015 12:42:45 -0300,
Fabio Estevam <festevam@gmail.com> a ?crit :
> On Sat, Feb 28, 2015 at 12:40 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > imx25-pdk.dts provides a more complete support than the board file version, so
> > let's get rid of the board file.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Do you mind if I submit a patch removing the eukrea mx25 board files?
> 
> If this is possible, then we can convert mx25 to a dt-only platform.
> 
no problem on our side, it was supposed to be removed after DT support
for this board was accepted but it seems the patch was never sent ;-)

Best regards,
Eric
