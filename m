From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 03 Nov 2011 11:14:41 +0900
Subject: [PATCH V6] SDHCI: S3C: Use generic clock names for sdhci bus clock
	options
In-Reply-To: <m2aa8e9zn3.fsf@bob.laptop.org>
References: <1320039876-21148-1-git-send-email-rajeshwari.s@samsung.com>
	<005301cc9958$bcf5aa10$36e0fe30$%kim@samsung.com>
	<m2aa8e9zn3.fsf@bob.laptop.org>
Message-ID: <013501cc99ce$58ea8920$0abf9b60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris Ball wrote:
> 
> Hi Kukjin,
> 
> On Wed, Nov 02 2011, Kukjin Kim wrote:
> >> This patch modifies the driver to stop depending on the clock names
> >> being passed from the platform and switch over to bus clock lookup
> >> using generic clock names.
> >>
> >> V6 Changes:
> >> Changed sprintf to snprintf as suggested by Chris Ball.
> >>
> >> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
> >
> > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> >
> > Hi Chirs,
> >
> > Could you please pick this up in your tree for this merge window?
> 
> Might be easier to have you send this, if you don't mind, since I'm
> still traveling and have already sent my main pull request.  Thanks!
> 
> Acked-by: Chris Ball <cjb@laptop.org>
> 
Hi Chris,

OK, I picked this up in my tree.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
