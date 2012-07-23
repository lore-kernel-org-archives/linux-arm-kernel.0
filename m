From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 Jul 2012 11:43:34 +0100
Subject: [PATCH] spi-orion: add device tree binding
In-Reply-To: <20120723100809.GC18778@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-3-git-send-email-andrew@lunn.ch>
 <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120722095328.GB5423@lunn.ch>
 <20120722190700.GD4557@opensource.wolfsonmicro.com>
 <20120722193243.GF5423@lunn.ch>
 <20120722224241.GH4557@opensource.wolfsonmicro.com>
 <20120723072749.GA18778@lunn.ch>
 <20120723093747.GD4435@opensource.wolfsonmicro.com>
 <20120723100809.GC18778@lunn.ch>
Message-ID: <20120723104333.GI4435@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 12:08:09PM +0200, Andrew Lunn wrote:
> From 528a19e9eda968cc673331d566cbfe20962d3b32 Mon Sep 17 00:00:00 2001
> From: Michael Walle <michael@walle.cc>
> Date: Wed, 6 Jun 2012 19:16:28 +0200
> Subject: [PATCHv3] spi-orion: add device tree binding

I really shouldn't need to remind you about the format for sending
patches :(

> +Optional properties:
> +- interrupts : Is currently not used.

Would it not be better to just omit this if it doesn't do anything and
doesn't have any semantics defined?

I've applied this.  If you could send the other patches that'd be
helpful...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/c69386a5/attachment.sig>
