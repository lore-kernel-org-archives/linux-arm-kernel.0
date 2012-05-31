From: thiago.bauermann@gmail.com (Thiago Jung Bauermann)
Date: Thu, 31 May 2012 01:32:10 -0300
Subject: Kernel 3.4 error on Dreamplug: [vectors]: mlock failed: Cannot
 allocate memory
In-Reply-To: <20120531030931.GX24238@titan.lakedaemon.net>
References: <1338401183.22894.11.camel@hactar>
 <20120531005109.GW24238@titan.lakedaemon.net>
 <1338431047.1822.11.camel@hactar>
 <20120531030931.GX24238@titan.lakedaemon.net>
Message-ID: <1338438730.4173.8.camel@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-05-30 at 23:09 -0400, Jason Cooper wrote:
> Please try a vanilla v3.4 kernel with CONFIG_ARM_APPENDED_DTB.

To be honest I don't feel comfortable about doing that. One
knowledgeable guy on the debian-kernel mailing list said that "the
Kconfig entry for ARM_APPENDED_DTB is quite scary about enabling it and
booting without a DTB appended"[1] and indeed it doesn't look very
encouraging.

Another message on the thread talks about "concerns about damaging other
boards"[2] (maybe I am misreading this one?).

[1] http://lists.debian.org/debian-kernel/2012/03/msg00049.html
[2] http://lists.debian.org/debian-kernel/2012/03/msg00645.html

Is there a risk of damaging the board if it is accidentally booted with
the wrong DTB or without one?

Does it help if I test with only dreamplug-3.4.0.patch (which adds
CONFIG_MACH_DREAMPLUG) applied?

-- 
[]'s
Thiago Jung Bauermann
