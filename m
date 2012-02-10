From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Feb 2012 19:16:17 +0900
Subject: [PATCH 9/9] ARM: EXYNOS: temporary fixup regarding
 get_core_count()
In-Reply-To: <CAH9JG2Us-Edqjq2FryX_wdHOkutdGdTzeCWMD2RjqNFCn=P9hA@mail.gmail.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-10-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2Us-Edqjq2FryX_wdHOkutdGdTzeCWMD2RjqNFCn=P9hA@mail.gmail.com>
Message-ID: <010001cce7dd$071e59c0$155b0d40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On 2/1/12, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---

[...]

> > -	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
> > +	if (soc_is_exynos5250())
> > +		ncores = 2;
> I saw the related mail thread, I wonder then how to handle this at
> other A15 board? Device Tree?

Well, as you know, the EXYNOS5250 has two A15 cores :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
