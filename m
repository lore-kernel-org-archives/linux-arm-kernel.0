From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Apr 2013 11:21:13 +0100
Subject: [PATCH 15/23] ARM: u300: set up board power from device tree
In-Reply-To: <1366624656-6648-1-git-send-email-linus.walleij@stericsson.com>
References: <1366624656-6648-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130424102113.GI5019@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 11:57:36AM +0200, Linus Walleij wrote:

> Hi Mark, this was especially tricky due to the absence of a
> function to get a named regulator without a device node. After
> some cleverness introducing a node for the board akin to the
> solution I did for Nomadik, this seems to be an acceptable way
> forward, any other suggestions welcome.

I would expect this to be bound based on the board name that appears in
the device tree which (given the way this stuff mostly works) I'd expect
to have a device node available.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130424/3a4ae311/attachment.sig>
