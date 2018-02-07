From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 07 Feb 2018 17:48:19 +0100
Subject: [PATCH 2/2] ARM: dts: exynos: Add support for HDMI audio on
 exynos5433-tm2
In-Reply-To: <CAJKOXPef+8UvinoK-9j6tPMgNavMw1K1BhLuibD5FomjRC9Sbg@mail.gmail.com>
References: <CGME20180205172216epcas2p3be603e84df81b28ee4c04c9b1c1c551f@epcas2p3.samsung.com>
 <20180205172110.9897-1-s.nawrocki@samsung.com>
 <20180205172110.9897-2-s.nawrocki@samsung.com>
 <CAJKOXPef+8UvinoK-9j6tPMgNavMw1K1BhLuibD5FomjRC9Sbg@mail.gmail.com>
Message-ID: <24c7afa6-5497-2182-7e4c-cd19dd891230@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2018 02:14 PM, Krzysztof Kozlowski wrote:
> Please move it further to i2s1 so all the nodes/labels will be ordered
> alphabetically. As with #1 I understand that there is no explicit
> dependency so please correct me if I am wrong.

Yes, there is no dependency, the only side effect will that the newly introduced 
ALSA PCM device for the HDMI port will not work until this patch is applied.

-- 
Regards,
Sylwester
