From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 16 Jun 2016 11:03:27 +0200
Subject: [STLinux Kernel] [PATCH 0/7] reset: Consumers to explicitly
 request 'exclusive' or 'shared' lines
In-Reply-To: <20160607092456.GE18047@dell>
References: <20160606155655.10860-1-lee.jones@linaro.org>
 <20160607084208.GB22960@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160607091543.GC18047@dell> <20160607092456.GE18047@dell>
Message-ID: <1466067807.3343.12.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Am Dienstag, den 07.06.2016, 10:24 +0100 schrieb Lee Jones:
[...]
> I guess it should really go into the -rcs, yes.  Since Hans' patch
> actually breaks a lot of devices.  I'm pretty surprised a patch
> capable of this much damage was actually accepted to be honest.

I wasn't aware there were more drivers already sharing resets, and
arguably before Hans' patches this wasn't really supported at all.
It only worked by circumstance.

> A better approach would have been to issue a warning, but keep the
> semantics the same for at least a couple of releases.  However, I
> guess the damage has been done now, so let's do what we can do fix
> it.

Agreed.

regards
Philipp
