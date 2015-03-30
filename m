From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 30 Mar 2015 15:25:07 +0200
Subject: ARM, earlyconsole and io mapping
In-Reply-To: <20150330141148.299f38a4@free-electrons.com> (Thomas Petazzoni's
 message of "Mon, 30 Mar 2015 14:11:48 +0200")
References: <87iodivgfm.fsf@free.fr>
 <20150330141148.299f38a4@free-electrons.com>
Message-ID: <87bnjavcr0.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> Dear Robert Jarzmik,
>
> On Mon, 30 Mar 2015 14:05:33 +0200, Robert Jarzmik wrote:
> A very early mapping of the I/O space is done in head.S, way before you
> get into C code:
>
>   http://lxr.free-electrons.com/source/arch/arm/kernel/head.S#L277
That's DEBUG_LL, right ? If that's what you mean, then I already have DEBUG_LL,
but that doesn't answer my question, as DEBUG_LL stops spitting logs after the
decompressor, and the errors I want to trap are between end of decompressor and
drivers probe.

And my question about earlycon remains, DEBUG_LL is not earlycon.

Cheers.

-- 
Robert
