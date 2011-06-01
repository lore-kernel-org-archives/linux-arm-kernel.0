From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Jun 2011 13:28:18 -0700
Subject: [PATCH] CPUFREQ/S5PV210, EXYNOS4: Add Kconfig options for S5PV210
	and EXYNOS4 CPUfreq drivers
In-Reply-To: <20110601195418.GA30806@redhat.com>
References: <1306476428-24808-1-git-send-email-dg77.kim@samsung.com>	<1306483489-10432-1-git-send-email-dg77.kim@samsung.com>	<4DE6977E.5080107@samsung.com>
	<20110601195418.GA30806@redhat.com>
Message-ID: <4DE6A0E2.5040807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/11 12:54, Dave Jones wrote:
> On Wed, Jun 01, 2011 at 12:48:14PM -0700, Kukjin Kim wrote:
>
>   >  Dave, could you please see below? If you're ok, will submit remained
>   >  others for Samsung cpufreq drivers.
>
> I'm ok with the principle of the patch, though it doesn't seem to include
> any driver movement, so just applying this will break the compile.
> (If it happens in another patch, they should really go together to
>   not break bisecting)
>
Hi Dave,

OK, will submit others which include moving cpufreq driver soon.

If you don't mind I will make some branch to merge in both, my tree
and yours.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
