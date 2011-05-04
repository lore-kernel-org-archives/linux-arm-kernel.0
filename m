From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 4 May 2011 10:56:10 -0500
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51 and
	i.MX53
In-Reply-To: <BANLkTinaFVXP10vbaF_We+kS2onwZAugQA@mail.gmail.com>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110413122503.GB1897@S2100-06.ap.freescale.net>
	<20110413124149.GR18850@pengutronix.de>
	<BANLkTinaFVXP10vbaF_We+kS2onwZAugQA@mail.gmail.com>
Message-ID: <BANLkTikHwmhrJHk7w+9WvLqVdhzbLM+qew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> address. I noticed in a patch somewhere last night that if MACH_MX5 is
> enabled, it uses 'and' instead of 'andne' to perform the masking. This
> will basically mean the derived address is still entirely CPU
> specific... unless I am out of date on the patches I am reviewing..

http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=blob;f=arch/arm/boot/compressed/head.S;h=437943d6b55e4282d03145dea77e36841e30c151;hb=bc676214b92db468c7b72dc495312809dbfc37bf#l248

Just backing myself up with the patch I'm referencing.

Curious question, where is the canonical tree-to-look-at for the
patches we're talking about? I don't feel comfortable at all
referencing a BSP kernel on a mainline mailing list :D

-- -
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
