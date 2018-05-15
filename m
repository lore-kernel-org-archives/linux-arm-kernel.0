From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 15 May 2018 18:02:02 +0200
Subject: [PATCH] arm64: dts: exynos: fix type of thermal trip points for
 Exynos7
In-Reply-To: <CAJKOXPdW7Ovo9GW=29tqa3rEAkSFgrEzbxm_wdGmRpamgk2-ig@mail.gmail.com>
References: <CGME20180515123755eucas1p278a9c1e9cb0101e406e3839e27f8b3b1@eucas1p2.samsung.com>
 <1702366.qL959G52Hi@amdc3058>
 <CAJKOXPdW7Ovo9GW=29tqa3rEAkSFgrEzbxm_wdGmRpamgk2-ig@mail.gmail.com>
Message-ID: <66371602.d1UHUK4g0h@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 15, 2018 02:59:33 PM Krzysztof Kozlowski wrote:
> On Tue, May 15, 2018 at 2:37 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > Currently Exynos thermal driver treats as "active" all specified
> > trip points before reaching maximum number of hardware supported
> > trip points.
> 
> The trip point type describe the way how system should act - use
> active or passive cooling. It is independent of thermal driver. I do

OK, I see it now. Please disregard this patch.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
