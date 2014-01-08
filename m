From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 8 Jan 2014 16:28:41 +0100
Subject: [PATCH v5 3/4] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
In-Reply-To: <52CD6E1E.5040409@free-electrons.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-4-git-send-email-gregory.clement@free-electrons.com>
 <20140108152139.GB15182@katana>
 <52CD6E1E.5040409@free-electrons.com>
Message-ID: <20140108152841.GD15182@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +	{
> >> +		.compatible = "marvell,mv78230-a0-i2c",
> >> +		.data = &mv64xxx_i2c_regs_mv64xxx
> >> +	},
> > 
> > I think a oneliner entry like the entries above is easier to read, but
> > that is very minor...
> 
> By using one line we would break the 80 character rule,
> hat why I did in this way.

This rule is there to keep code readable. If it doesn't help
readability, it may/can/should be broken IMO. It's a mileage, though.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/dc7ee46a/attachment.sig>
