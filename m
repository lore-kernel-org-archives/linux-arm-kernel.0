From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 16 Oct 2015 08:44:13 +0200
Subject: [PATCH 5/6] ARM: dts: sun8i: Add NMI interrupt controller node
In-Reply-To: <1444840342-9233-6-git-send-email-wens@csie.org>
References: <1444840342-9233-1-git-send-email-wens@csie.org>
 <1444840342-9233-6-git-send-email-wens@csie.org>
Message-ID: <20151016064413.GH2711@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 12:32:21AM +0800, Chen-Yu Tsai wrote:
> The NMI interrupt controller is in charge of the NMI pin exposed by
> the SoC to the PMIC. The PMIC signals interrupts through this.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151016/04ce1372/attachment.sig>
