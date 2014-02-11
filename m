From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 11 Feb 2014 11:47:15 +0530
Subject: [PATCH v1 0/1] Boot all secondary cores on Exynos SoC's
In-Reply-To: <1392084929-14116-1-git-send-email-t.dakhran@samsung.com>
References: <1392084929-14116-1-git-send-email-t.dakhran@samsung.com>
Message-ID: <CAK9yfHzoBCBpUqhmOMvXmkR510EViBcciveD0rRNtiHxMRC9TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarek,

On 11 February 2014 07:45, Tarek Dakhran <t.dakhran@samsung.com> wrote:
> Due to implementation of exynos_boot_secondary function
> only one secondary core boots on Exynos SoC's.

Even without this patch I could boot the secondary CPUs on Exynos4210, 4412 and
5250 based boards with the latest Linux kernel (v3.14-rc2+). Is this
patch required for
a specific use case or am I missing something?

---
With warm regards,
Sachin
