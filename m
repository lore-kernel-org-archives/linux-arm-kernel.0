From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Jul 2014 09:26:54 +0200
Subject: [PATCH v4 0/6] clk: sunxi: fixes, cleanups and A23 basic clocks
In-Reply-To: <20140702223552.7440.60829@quantum>
References: <1403798144-32188-1-git-send-email-wens@csie.org>
 <20140702223552.7440.60829@quantum>
Message-ID: <20140703072654.GC31996@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Wed, Jul 02, 2014 at 03:35:52PM -0700, Mike Turquette wrote:
> Quoting Chen-Yu Tsai (2014-06-26 08:55:38)
> > Hi everyone,
> > 
> > This is v4 of the sun8i clock series, which adds basic clock
> > support for the A23 SoC. It is based on my initial sun8i bring
> > up series [1]. This series was split up from the original A23
> > series [2]. Yet to come are more clocks, reset controllers,
> > prcm, pinctrl, and mmc.
> 
> Hello Chen-Yu,
> 
> This series looks good to me.
> 
> Maxime,
> 
> I see that you Acked it already. Are you planning to roll this into a
> pull request later on?

I think that was an question Emilio asked a few days ago :)

It would probably be easier if we just handle all the sunxi clocks
ourselves, so I guess Emilio can just send you a pull request later
on.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140703/e60c5ac0/attachment.sig>
