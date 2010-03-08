From: metan@ucw.cz (Cyril Hrubis)
Date: Mon, 8 Mar 2010 09:25:30 +0100
Subject: bit errors on spitz
In-Reply-To: <20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
References: <20100305212708.GC21773@elf.ucw.cz>
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
Message-ID: <20100308082530.GA1982@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> dmesg would not be useful, it usually hits user programs. Like... mutt
> suddenly displaying , instead of - in the header. Program failing to
> start because function printg is not found (it was not exactly
> printf->printg,  I don't remember exact symbol), ping complaining
> about discarding corrupted packets, etc.
> 
> (Or of course, kernel oopsing or not going from suspend at all. But as
> even user data are being corrupted, oops is not likely to be
> interesting and system is typically not in state to capture it any more.)
>

Well I've seen empty lines when editing file with vim (these that are starting
with blue tilda) in the middle of file. And sometimes programs segfaults for no
good reason. Just today I've run "apt-get update" and got:

symbol lookup error: apt-get: undefined symbol: _ZN16pkgAcquireStatus4StopEv

While the correct symbol seems to be _ZN16pkgAcquireStatus4.

When running 'make' in kernel directory and closing the display sometimes
machine dies and nothing but reset under battery cover helps. I remeber waking
up in the morning, opening the device and reseting the device. And it seems to
be provoked much more by active CF wifi card.

-- 
metan
