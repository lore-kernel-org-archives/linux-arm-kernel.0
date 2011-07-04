From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 04 Jul 2011 19:25:48 +0900
Subject: [PATCH 1/7] ARM: EXYNOS4: Add external GIC io memory mapping
In-Reply-To: <BANLkTikYvCVVZP+z06466x1maEi3CDcq5w@mail.gmail.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
	<1308555258-4322-2-git-send-email-chaos.youn@samsung.com>
	<BANLkTikYvCVVZP+z06466x1maEi3CDcq5w@mail.gmail.com>
Message-ID: <005801cc3a34$bff29bc0$3fd7d340$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> > ?#define EXYNOS4_PA_COMBINER ? ? ? ? ? ?0x10448000
> 
> Isn't this 0x10440000 if we are going to use External GIC?
> 
Oops, you're right, thanks for your pointing out.
Yes, should be 0x10440000.

When I apply this, I will fix it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
