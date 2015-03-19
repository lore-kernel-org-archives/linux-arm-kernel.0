From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Thu, 19 Mar 2015 08:59:25 +0200
Subject: [PATCH 2/2] ARM: dts: sunxi: Remove overclocked/overvoltaged OPP
In-Reply-To: <1426732773-7179-3-git-send-email-wens@csie.org>
References: <1426732773-7179-1-git-send-email-wens@csie.org>
 <1426732773-7179-3-git-send-email-wens@csie.org>
Message-ID: <20150319085925.70d8a10d@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Mar 2015 10:39:33 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> Without proper regulator support for individual boards, it is dangerous
> to have overclocked/overvoltaged OPPs in the list. Cpufreq will increase
> the frequency without the accompanying voltage increase, resulting in
> an unstable system.
> 
> Remove them for now. We can revisit them with the new version of OPP
> bindings, which support boost settings and frequency ranges, among
> other things.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun5i-a13.dtsi | 3 +--
>  arch/arm/boot/dts/sun7i-a20.dtsi | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

What about the sun4i-a10.dtsi file? Was it forgotten or skipped
deliberately?

-- 
Best regards,
Siarhei Siamashka
