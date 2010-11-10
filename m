From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 Nov 2010 15:04:27 -0200
Subject: [PATCHv3 1/2] ARM: imx: Add core definitions for MX53
In-Reply-To: <20101110164640.GV6017@pengutronix.de>
References: <1288972551-21877-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20101109214607.GG6017@pengutronix.de>
	<86A0E76937111F4C92FABEC0A20988510523D224@az33exm21>
	<20101110164640.GV6017@pengutronix.de>
Message-ID: <AANLkTinmXin65ReWsUf02ia7FMvHfeqkVeaGu6Usmdw5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 10, 2010 at 2:46 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
...

>> Agreed, but I was unsure how to proceed with adding clock code for mx53.
>> Should I merge mx53 clock code into clock-mx51 and rename clock-mx51?
>
> Yes, to something like clock-mx51-mx53.c
>

Or maybe clock-mx5x.c would be more generic.

This way when any other MX5x processor gets added we don't need to
change the file name again.

Regards,

Fabio Estevam
