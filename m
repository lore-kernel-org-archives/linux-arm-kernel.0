From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 21:17:16 +0800
Subject: [PATCH 0/3] Add eSDHC UHS-I/HS200 mode support for
 ls1012a/ls1046a/ls208xa
In-Reply-To: <DB6PR0401MB253641C6AB25737F9F57EE8DF81E0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1492746756-12024-1-git-send-email-yangbo.lu@nxp.com>
 <CAPDyKFp_TWSj7FH6KagU4gz+A9CR-thwU9b1WaSEgupZMBAyaQ@mail.gmail.com>
 <DB6PR0401MB253641C6AB25737F9F57EE8DF81E0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
Message-ID: <20170503131714.GD24392@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 09:01:28AM +0000, Y.B. Lu wrote:
> > By curiosity I tried applying these to my mmc tree, but they don't apply.
> > So I can pick them, even with acks.
> > Also it's too difficult for me to host an immutable branch with the
> > relevant sdhci-esdc changes, because of additional sdhci dependencies.
> > 
> > Perhaps just easier to pick this for 4.13 or 4.12 rc2.
> 
> [Lu Yangbo-B47093] Hi Uffe, I agree.
> These patches are based on Shawn's tree which has the latest layerscape board dts.
> Actually I'm not sure which git tree I should send these patches to according to MAINTAINERS, but I saw Shawn had merged some layerscape board dts before.
> 
> Hi Shawn,
> Am I right to send these patches to you for reviewing? Which git tree do you recommend I should send these patches to?

Yes, currently arm64 freescale dts patches flows to mainline as below.

  my imx/dt64 branch --> arm-soc tree --> mainline

Shawn
