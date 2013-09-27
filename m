From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Sep 2013 19:35:57 +0300
Subject: [PATCH 1/2] ARM: sunxi: Split out the DT machines for sun6i and
 sun7i
In-Reply-To: <1379772706-7028-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1379772706-7028-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130927163557.GU2954@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 21, 2013 at 09:11:45AM -0500, Maxime Ripard wrote:
> The A20 and A31 SMP code have a different way of bringing up a new core.
> This will prevent us from using the same set of smp_operations for the
> two SoCs family.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied to my sunxi/core-for-3.13 branch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130927/ec020dd9/attachment-0001.sig>
