From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 Oct 2015 22:36:43 +0200
Subject: [PATCH 1/6] mfd: axp20x: Add AXP223 to list of supported PMICs
 in DT bindings
In-Reply-To: <1444840342-9233-2-git-send-email-wens@csie.org>
References: <1444840342-9233-1-git-send-email-wens@csie.org>
 <1444840342-9233-2-git-send-email-wens@csie.org>
Message-ID: <20151015203643.GF2711@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 12:32:17AM +0800, Chen-Yu Tsai wrote:
> The AXP223 is a new PMIC commonly paired with Allwinner A23/A33 SoCs.
> It is functionally identical to AXP221; only the regulator default
> voltage/status and the external host interface are different.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151015/7464e43d/attachment.sig>
