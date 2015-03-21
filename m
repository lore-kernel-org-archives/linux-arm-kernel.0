From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 21 Mar 2015 19:20:35 +0100
Subject: [PATCH v2 0/2] ARM: dts: sunxi: Fix cpufreq instabilities
In-Reply-To: <1426834160-10409-1-git-send-email-wens@csie.org>
References: <1426834160-10409-1-git-send-email-wens@csie.org>
Message-ID: <20150321182035.GE2774@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 02:49:18PM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> Here's v2 of the sunxi cpufreq dts fixes, aimed at 4.0.
> 
> The first patch limits the Olimex A10-Lime to 912MHz, as a few people
> reported on IRC that it was unstable at 1008MHz.
> 
> The second patch removes the overclocking settings from sun[457]i dts,
> so all the boards will be stable, regardless of whether regulators
> were added or not.
> 
> I would like to revisit this after the new OPP bindings are merged
> and support added to cpufreq-dt.

Applied both, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150321/6037c727/attachment.sig>
