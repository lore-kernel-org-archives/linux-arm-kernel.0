From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 10 Jun 2011 19:24:05 +0300
Subject: [PATCH 2/4] msm: iommu: move to drivers/iommu/
In-Reply-To: <8yamxhsklhd.fsf@huya.qualcomm.com>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
	<1307522062-19273-3-git-send-email-ohad@wizery.com>
	<8yamxhsklhd.fsf@huya.qualcomm.com>
Message-ID: <BANLkTi=owGc5JU1eF5wZmgiC0GbTCury8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 9, 2011 at 1:27 AM, David Brown <davidb@codeaurora.org> wrote:
> Moving the driver is good. ?I'm wondering what we should do with
> iommu_dev.c, though. ?Wouldn't it make sense to move this file as well?

Yeah, it does make sense. I'll move that one too, thanks.
