From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 30 Oct 2014 16:53:06 +0100
Subject: [PATCH 4/6] ARM: dts: sun9i: Add GPIO LEDs for A80 Optimus board
In-Reply-To: <54500866.7060909@suse.de>
References: <1414489843-2680-1-git-send-email-wens@csie.org>
 <1414489843-2680-5-git-send-email-wens@csie.org>
 <20141028201605.GA9255@lukather> <54500866.7060909@suse.de>
Message-ID: <20141030155306.GL21251@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 10:19:34PM +0100, Andreas F?rber wrote:
> >> +			gpios = <&pio 7 0 0>;
> >> +		};
> >> +
> >> +		/* led3 is on PM15, in R_PIO */
> > 
> > You were saying that there is three LEDs, why start the numbering at
> > 2?
> 
> They are labeled "LED2", "LED4", "LED3" right-to-left.
> Additionally there's a "PWR" LED, maybe that counts as number 1...

I knew I should have looked at my board. That makes perfect sense,
thanks.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/56de73d0/attachment.sig>
