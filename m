From: dwalker@fifo99.com (Daniel Walker)
Date: Wed, 23 Mar 2011 05:50:47 -0700
Subject: [PATCH] msm: iommu: Use relaxed register access functions
In-Reply-To: <1300392119-8062-1-git-send-email-stepanm@codeaurora.org>
References: <1300392119-8062-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1300884647.6117.6.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-17 at 13:01 -0700, Stepan Moskovchenko wrote:
> Use the relaxed versions of readl/writel for IOMMU register
> access, inserting barriers where appropriate.

Could you provide comments on why you need barriers in the various
places you've placed them.

Daniel
