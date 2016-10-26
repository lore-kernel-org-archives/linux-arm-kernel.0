From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 26 Oct 2016 16:39:42 +0530
Subject: [PATCH 3/5] ARM: davinci: enable gpio poweroff in default config
In-Reply-To: <1477075018-20176-4-git-send-email-david@lechnology.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
 <1477075018-20176-4-git-send-email-david@lechnology.com>
Message-ID: <832356cd-a95b-eb00-b81b-c730da1e9e3a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 October 2016 12:06 AM, David Lechner wrote:
> The gpio-poweroff driver is needed by LEGO MINDSTORMS EV3 (AM1808 based
> board).
> 
> Signed-off-by: David Lechner <david@lechnology.com>

For defconfig patches, we have been using the davinci_all_defconfig
prefix (see git log --oneline arch/arm/configs/davinci_all_defconfig).

Applied to v4.10/defconfig with subject line changed to:

"ARM: davinci_all_defconfig: enable gpio poweroff driver"

Thanks,
Sekhar
