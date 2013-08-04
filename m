From: broonie@kernel.org (Mark Brown)
Date: Sun, 4 Aug 2013 18:22:05 +0100
Subject: [PATCH V2 7/8] ARM: dts: wm8994: Add wm8994 support on smdk5420
In-Reply-To: <CAAgF-BcPT24LcQe5SUyOP3qHThXqZ1mVts=_cnww3EAUYEYikw@mail.gmail.com>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
 <1374845812-7803-8-git-send-email-padma.v@samsung.com>
 <20130726151902.GL9858@sirena.org.uk>
 <CAAgF-Be8SNxTZv1yFCwH6yJ-O_3R4reh=3y+pSCLJYW7S9TkUg@mail.gmail.com>
 <CAAgF-Bexp_fGT8KV+TQ0_kZLJBtq7UK=TG4eYRA6qpTSL+scxg@mail.gmail.com>
 <20130729134311.GX9858@sirena.org.uk>
 <CAAgF-BeDYm1jNJpkyfTeS5HjpEuaHiumFq+D_PNs=QYG6-Px+w@mail.gmail.com>
 <CAAgF-BcPT24LcQe5SUyOP3qHThXqZ1mVts=_cnww3EAUYEYikw@mail.gmail.com>
Message-ID: <20130804172205.GT9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 04:15:28PM +0530, Padma Venkat wrote:

> Sorry for giving some what wrong info here. I verified the schemata.
> There is a switch on the board which can be used to select the input
> clock of codec MCLK1. We can either select oscillator clock which is
> 16.9MHz which is on the board or XCLKOUT which is from PMU or
> i2scdclk(codec slave mode). Right now we are using oscillator clock as
> input clock to MCLK1.

I agree that going with whatever the board ships with as default seems
sensible.  Might be worth putting in a comment with the XCLKOUT option
saying how it maps into the control on the board.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130804/e55ce207/attachment.sig>
