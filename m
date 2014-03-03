From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 04 Mar 2014 08:49:26 +0900
Subject: [PATCH V9 2/2] ARM: dts: Enable ahci sata and sata phy
In-Reply-To: <C12D2EA6-2766-4C9A-8746-9B8E1A5844CD@codeaurora.org>
References: <1393824160-27040-1-git-send-email-yuvaraj.cd@samsung.com>
 <1393824160-27040-3-git-send-email-yuvaraj.cd@samsung.com>
 <53146E84.7060508@ti.com>
 <C12D2EA6-2766-4C9A-8746-9B8E1A5844CD@codeaurora.org>
Message-ID: <000301cf373b$36314330$a293c990$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 04, 2014 1:02 AM, Kumar Gala wrote:
> On Mar 3, 2014, at 5:59 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> 
> >
> >
> > On Monday 03 March 2014 10:52 AM, Yuvaraj Kumar C D wrote:
> >> This patch adds dt entry for ahci sata controller and its
> >> corresponding phy controller.phy node has been added w.r.t
> >> new generic phy framework.
> >>
> >> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> >
> > This should go via exynos dt tree.
> >
> > FWIW
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> -
> 
> Its a nit, but the subject really should have 'exynos' or some related qualifier. 
> We aren't enabling ahci sata & phy for all of ARM

I agree with your opinion.
The subject should be fixed in order to get rid of confusion.

For example, one of the followings looks good.

  ARM: dts: exynos5250: Enable ahci sata and sata phy
  ARM: dts: Enable ahci sata and sata phy for exynos5250

Best regards,
Jingoo Han

> 
> - k
> 
> --
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
