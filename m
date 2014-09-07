From: broonie@kernel.org (Mark Brown)
Date: Sun, 7 Sep 2014 16:01:22 +0100
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <540C202E.2060009@collabora.co.uk>
References: <20140905115704.GO13515@arm.com> <20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk>
Message-ID: <20140907150122.GK2601@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 07, 2014 at 11:06:54AM +0200, Javier Martinez Canillas wrote:

> But maybe we could add a boot argument similar to "clk_ignore_unused" but for
> regulators? Something like "regulator_ignore_unused" that would prevent the
> regulator core to disable unused regulators? If Mark agrees with that idea
> I'll be glad to propose a patch.

I'm not all that sympathetic to the idea; we already have quite enough
quality problems with the way people hook up regulators without
providing yet another way for them to hack around things, I'm concerned
it'll just make things more fragile as people require magic command line
arguments to get things working.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140907/25881ee3/attachment.sig>
