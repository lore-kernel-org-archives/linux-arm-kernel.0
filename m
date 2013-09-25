From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Sep 2013 23:03:51 +0300
Subject: [PATCH 06/26] clk: sunxi: declare OF clock provider
In-Reply-To: <1379526839-14798-7-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-7-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130925200351.GL2954@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Wed, Sep 18, 2013 at 07:53:39PM +0200, Sebastian Hesselbarth wrote:
> Common clock framework allows to register clock providers to get called
> on of_clk_init() by using CLK_OF_DECLARE. This converts sunxi clock
> providers to make use of it and get rid of the mach specific clk init
> call. As sunxi has a bunch of independent clk provider nodes, we hook
> current clock init to board compatible to make it called once.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130925/a4c861fa/attachment.sig>
