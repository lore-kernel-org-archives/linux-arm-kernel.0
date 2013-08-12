From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Aug 2013 10:17:26 +0200
Subject: [PATCHv3 02/10] clk: sunxi: fix initialization of basic clocks
In-Reply-To: <1375609657-15434-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1375609657-15434-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375609657-15434-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130812081726.GK2911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Sun, Aug 04, 2013 at 11:47:29AM +0200, Maxime Ripard wrote:
> From: Emilio L?pez <emilio@elopez.com.ar>
> 
> With the recent move towards CLK_OF_DECLARE(...), the driver stopped
> initializing osc32k, which is compatible "fixed-clock". This is because
> we never called of_clk_init(NULL). Fix this by moving the only other
> simple clock (osc24M) to use CLK_OF_DECLARE(...) and call of_clk_init(NULL)
> to initialize both of them.

I'd like this patch to go in 3.12, and I need it to merge quite a few
other patches. Could you either review or merge it?

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130812/594aa6a6/attachment.sig>
