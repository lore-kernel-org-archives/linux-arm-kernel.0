From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 23 Aug 2011 17:59:53 +0300
Subject: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
In-Reply-To: <20110823140746.GP2079@amd.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-2-git-send-email-ohad@wizery.com>
	<20110823140746.GP2079@amd.com>
Message-ID: <CAK=WgbZYuuKHUu6P+nfNzPgF4QmoL=T9+yquc=rMXRh4QE9grg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 5:07 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> Can this be easily converted to a spin_lock?

Sure, thanks for reviewing.
