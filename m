From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Jan 2015 11:23:19 +0100
Subject: [PATCH 01/17] ARM: sunxi: Register cpufreq-dt for sun[45678]i
In-Reply-To: <1420511727-8242-2-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-2-git-send-email-wens@csie.org>
Message-ID: <20150107102319.GH7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 10:35:11AM +0800, Chen-Yu Tsai wrote:
> On sun[45678]i, we have one cluster of identical cores sharing a
> clock, which is ideal for using cpufreq-dt. Register a platform
> device for cpufreq-dt.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150107/aeefe19e/attachment-0001.sig>
