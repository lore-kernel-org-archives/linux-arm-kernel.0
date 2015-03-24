From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 Mar 2015 14:51:04 -0700
Subject: [PATCH resend v2 0/2] ARM: dts: sunxi: Fix cpufreq instabilities
In-Reply-To: <1427216007-9185-1-git-send-email-wens@csie.org>
References: <1427216007-9185-1-git-send-email-wens@csie.org>
Message-ID: <20150324215104.GA23664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 12:53:25AM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> Here's v2 of the sunxi cpufreq dts fixes, rebased onto v4.0-rc5.
> I assume you'll fix up the merge conflicts with 4.1 stuff?
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/0016420b/attachment.sig>
