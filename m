From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 18 Apr 2011 17:43:00 +0900
Subject: [GIT PULL] Samsung fixes for 2.6.39-rc4
In-Reply-To: <008701cbfd45$94dd8f70$be98ae50$%kim@samsung.com>
References: <008701cbfd45$94dd8f70$be98ae50$%kim@samsung.com>
Message-ID: <BANLkTik=-YbSD3D+9twqDm3uKR3tm+V+=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Can you check this patch also?
http://lists.arm.linux.org.uk/lurker/message/20110329.064902.fb2f620c.en.html

Fix cpuinit section mismatch(es).

WARNING: modpost: Found 2 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'

Thank you,
Kyungmin Park

On Mon, Apr 18, 2011 at 6:22 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Hi Linus,
>
> Please pull Samsung fixes from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> s5p-fixes-for-linus
>
> These things are small fixes for 2.6.39-rc4.
> If any problems, please let me know.
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> The following changes since commit a6360dd37e1a144ed11e6548371bade559a1e4df:
>
> ?Linux 2.6.39-rc3 (2011-04-11 17:21:51 -0700)
>
> are available in the git repository at:
> ? git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> s5p-fixes-for-linus
>
> Abhilash Kesavan (2):
> ? ? ?ARM: S5P: Remove unused s3c_pm_check_resume_pin
> ? ? ?ARM: SAMSUNG: Fix build failure in PM CRC check code
>
> Maurus Cuelenaere (1):
> ? ? ?ARM: SAMSUNG: Fix warning 's3c_pm_show_resume_irqs' defined but not
> used
>
> ?arch/arm/plat-s5p/pm.c ? ? ? ? ? | ? 11 -----------
> ?arch/arm/plat-samsung/pm-check.c | ? ?6 ------
> ?arch/arm/plat-samsung/pm.c ? ? ? | ? ?5 +++--
> ?3 files changed, 3 insertions(+), 19 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
