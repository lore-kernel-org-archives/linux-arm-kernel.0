From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Feb 2012 19:23:25 +0900
Subject: [PATCH v2] ARM: Exynos4: Add cpu-offset property in gic device
 tree node
In-Reply-To: <4F2819D0.7090002@samsung.com>
References: <1328023789-4672-1-git-send-email-thomas.abraham@linaro.org>
 <4F2819D0.7090002@samsung.com>
Message-ID: <067c01cce714$db77de90$92679bb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Karol Lewandowski wrote:
> 
> On 31.01.2012 16:29, Thomas Abraham wrote:
> > Commit db0d4db22a78 ('ARM: gic: allow GIC to support non-banked setups)
> > requires a cpu-offset property to be specified for non-banked gic
> > controllers, which is the case for Exynos4.
> >
> > Reported-by: Karol Lewandowski<k.lewandowski@samsung.com>
> 
> ( Minor note - my email address lacks 'i' at the end, i.e. it's
>    k.lewandowsk@ :)
> 
> > Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> > ---
> > This patch solves the issue of boot failure with SMP enabled kernel for
> > Exynos4 device tree enabled machine.
> 
> Tested-by: Karol Lewandowski <k.lewandowsk@samsung.com>
> 
Applied with fixing Karol's e-mail address.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
