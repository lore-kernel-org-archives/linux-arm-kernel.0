From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 4 Jun 2010 16:42:00 +0800
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <AANLkTilyIb8WDAanNHlQKHco6rSjzNjNS9Q3TpWQqt8o@mail.gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<4C083BCF.2060500@bluewatersys.com>
	<201006040310.15019.marek.vasut@gmail.com>
	<201006041036.39059.pieterg@gmx.com>
	<AANLkTilyIb8WDAanNHlQKHco6rSjzNjNS9Q3TpWQqt8o@mail.gmail.com>
Message-ID: <AANLkTin1Kt5ydz0Ipq04zYnzEfp69xv0Etu2Iu7FyXAo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That's supposed to be possible with ASoC, what's the exact problem?

- eric from G1

On Jun 4, 2010 4:39 PM, "pieterg" <pieterg@gmx.com> wrote:

On Friday 04 June 2010 03:10:14 Marek Vasut wrote:
> I just tested, PXA (mach-pxa) probably can be c...
For my boards (colibri) I see only one exception; I haven't managed to build
a single kernel with support for different AC97 chips.

I have to build separate WM9715 and UCB1400 kernels.

Rgds, Pieter


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at list...
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100604/1bebde89/attachment-0001.htm>
