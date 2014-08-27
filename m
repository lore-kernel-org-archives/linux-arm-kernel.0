From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Aug 2014 13:34:50 +0200
Subject: [PATCH 00/14] Support 64bit Cortex A57 based Exynos7 SoC
In-Reply-To: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <53FDC25A.2010806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naveen,

On 27.08.2014 11:44, Naveen Krishna Chatradhi wrote:
> This patchset supports new Exynos7 Samsung SoC based on Cortex-A57.
> Exynos7 is a System-On-Chip (SoC) that is based on 64-bit
> ARMv8 RISC processor.

A general issue with this series is that it introduces a very generic
name for a very specific single SoC. We remember exactly the same cases
for Exynos4 (original name used for Exynos5250) and Exynos5 (Exynos5250)
and we should have learned that it is better to use a specific name
first and only then try to make things common if it turns out to be
appropriate.

Best regards,
Tomasz
