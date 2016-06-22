From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Jun 2016 12:02:06 +0200
Subject: [PATCH v3 5/8] rtc: ac100: Add clk output support
In-Reply-To: <1466391138-12862-6-git-send-email-wens@csie.org>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-6-git-send-email-wens@csie.org>
Message-ID: <20160622100206.GV26668@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 20, 2016 at 10:52:15AM +0800, Chen-Yu Tsai wrote:
> +	/*
> +	 * The ADDA 4 MHz clock is from the codec side of the AC100,
> +	 * which is likely a different power domain. However, boards
> +	 * always have both sides powered on, so it is impossible to
> +	 * test this.
> +	 */

If that ADDA clock is exposed by the codec, why are you putting it in
the RTC?

Thanks,
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160622/fd8b1f0f/attachment-0001.sig>
