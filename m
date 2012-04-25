From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 25 Apr 2012 07:59:21 +0200
Subject: [GIT PULL] Samsung fixes-2 for v3.4
In-Reply-To: <4F974625.1030607@samsung.com>
References: <4F89A0A5.5030806@samsung.com>
 <CAOesGMhp48Kh+tJ1534G=ze0CEcVBpaPQxVKs8A31difVw9h9Q@mail.gmail.com>
 <4F974625.1030607@samsung.com>
Message-ID: <016501cd22a8$8fd16f90$af744eb0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Wednesday, April 25, 2012 2:33 AM Kukjin Kim wrote:

> > Looking at your current fixes-3 branch, it's unclear at a quick glance
> > why the clk_type patch is a bugfix, and especially why it is a
> > regression fix -- it looks like a cleanup. We're very close to 3.4-rc3
> 
> I agree that the removing clk_type member in sdhci platform data should
> be included in cleanup stuff, it is useless in current mainline though.
> 
> Marek, is this ok to you?

Yes, this patch is not strictly needed to get SDHCI working again on v3.4-rcX.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
