From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 6 Jan 2017 08:18:05 +0200
Subject: [PATCH v2 3/4] ARM64: dts: exynos5433: use macros for pinctrl
 configuration on Exynos5433
In-Reply-To: <20170106022343.5w4d7pkydrfh2n75@gangnam.samsung>
References: <CGME20161230041427epcas1p1151d6e28fac143c63efaf4f7c8ed432d@epcas1p1.samsung.com>
 <20161230041421.24448-1-andi.shyti@samsung.com>
 <20161230041421.24448-4-andi.shyti@samsung.com>
 <CACRpkdaz9AyFJs1Th_SVexqKaP-=iPF0G-1YXOCoSmrQH8ZHDA@mail.gmail.com>
 <20161230151724.5wlp4hbphasmw3rg@kozik-lap>
 <CACRpkdbX_MuLSCerq08-1VZV6VJfynjkv1QOr7ssOCGvM5aB_Q@mail.gmail.com>
 <20170105200807.54j2ebve6kqd5bob@kozik-lap>
 <20170106022343.5w4d7pkydrfh2n75@gangnam.samsung>
Message-ID: <20170106061805.6g57e6iulrclwieb@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 11:23:43AM +0900, Andi Shyti wrote:
> Hi Krzysztof,
> 
> > Andi,
> > Please fix missing Signed-off-by and resend with Linus' tags for #1 and
> > #2 and with other accumulated tags.
> 
> patch #1 has already been merged in mainline:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=1259feddd0f83649d5c48d730c140b4f7f3fa288
> 
> and patch #2 is in LinusW's -next branch.

Yes, but it is gone from devel so I suppose it will be removed from
for-next in the future as well.

> does it still make sense to send them again? If you want I can
> send again patch 3 and 4 as independent patches with Chanwoo's
> review (the only tags).

No, no need. I wanted resend only because of #1 but it is merged as you
said.

Best regards,
Krzysztof
