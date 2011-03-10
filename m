From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 Mar 2011 13:37:52 +0900
Subject: [PATCH 2/3] ARM: EXYNOS4: Suspend to RAM Support
In-Reply-To: <20110309082319.GC605@n2100.arm.linux.org.uk>
References: <1299636521-4831-1-git-send-email-jc.lee@samsung.com>
	<1299636521-4831-3-git-send-email-jc.lee@samsung.com>
	<20110309082319.GC605@n2100.arm.linux.org.uk>
Message-ID: <006201cbdedc$efd42420$cf7c6c60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Wed, Mar 09, 2011 at 11:08:40AM +0900, Jaecheol Lee wrote:
> > This patch adds support suspend to ram for EXYNOS4210.
> > As a note, this includes function of outer cache flush
> > because it is used before entering PM.
> 
> This should be updated to use the generic CPU sleep support, found in my
> tree.

Russell, thanks :)

Yeah it should be based on generic CPU sleep.

As I know, his second patch will be made based on it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
