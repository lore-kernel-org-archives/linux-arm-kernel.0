From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Feb 2016 11:25:48 -0800
Subject: [PATCH v3 00/10] arm64: Introduce Allwinner A64 and Pine64 support
In-Reply-To: <56CED1CB.8040807@arm.com>
References: <1456165255-31013-1-git-send-email-andre.przywara@arm.com>
 <56CED1CB.8040807@arm.com>
Message-ID: <20160225192548.GK4736@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 25, 2016 at 10:04:59AM +0000, Andre Przywara wrote:
> Hi Maxime,
> 
> can you give me a quick assessment on how we can progress from here?
> 
> Is it already too late for at least some of the patches to go into 4.6?

I think we still have a major disagreement on the clocks part, and
yeah, it's too late for 4.6, I'm going to send the PR tomorrow, and am
merging the final patches that didn't have the attention they deserved
lately.

> If not, can you at least merge the Kconfig patch (3/10)

This one was already merged

> and the pinctrl driver (if that goes via your tree at all)? Do you
> need more reviews or Acks?

And I just gave my Acked-by for this one, but it will go through the
pinctrl tree, hopefully in time.

> Of the prerequisite patches for a clean arm64 compile I see that the
> sunxi-rsb is in your for-next branch, but not in -next itself. Also I
> got a message about the sunxi-ss Kconfig patch to be applied, but cannot
> find it in -next either. All the other patches have made it into -next
> as of today.

Great, I'll push the A64 kconfig patch in next today, and see if
there's any fallout.

> Also are you happy with the PLL6 reuse patch I sent on Monday and can I
> base the A64's PLL7 clock on that?
> Or do you prefer another approach here? I am happy to discuss this on
> the list then.

I just commented on it.

Sorry for the unresponsiveness lately,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/5d167351/attachment-0001.sig>
