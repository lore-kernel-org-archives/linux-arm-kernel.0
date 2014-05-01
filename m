From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 01 May 2014 23:11:34 +0200
Subject: [PATCH v3 00/16] exynos5420: clock file cleanup
In-Reply-To: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
References: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <5362B886.9040308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaik,

On 24.04.2014 15:03, Shaik Ameer Basha wrote:
> Many changes/fixes have been identified for clock file for exynos5420.
> These include correct parents, bit fields, new clocks etc. Existing
> files needs some correction in terms of names of the clock and
> indentation. These issues are addressed in this patch series. It also
> replaces the usage of enums with macro as clock ids.
>
> This patch series is rebased on,
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git:master
>
> This patch is also dependent on the following patch.
> ARM: dts: add dt node for sss module for exynos5250/5420

I think it would be nice to mention on what hardware this series was 
tested and how.

Also I'd like to see contents of /sys/kernel/debug/clk/clk_summary and 
/sys/kernel/debug/clk/orphans/ before and after applying this series.

Best regards,
Tomasz
