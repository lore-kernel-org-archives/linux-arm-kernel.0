From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Oct 2015 14:56:30 +0200
Subject: [PATCH 3/3] ARM: dts: sun4i: Add AXP209 PMU regulators for
 pcDuino1/2
In-Reply-To: <1443985128-23137-4-git-send-email-siarhei.siamashka@gmail.com>
References: <1443985128-23137-1-git-send-email-siarhei.siamashka@gmail.com>
 <1443985128-23137-4-git-send-email-siarhei.siamashka@gmail.com>
Message-ID: <20151005125630.GN2696@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 04, 2015 at 09:58:48PM +0300, Siarhei Siamashka wrote:
> This allows voltage-scaling with cpufreq-dt. The reliability of
> voltage-scaling has been checked by reducing the voltage of all
> operating points by 0.025V (for extra safety headroom) and running
> libjpeg-turbo decoding tests on 5 pcDuino2 boards. It means that
> the standard sun4i voltages should be perfectly fine too.
> 
> Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/76e13837/attachment.sig>
