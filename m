From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 30 May 2018 00:37:35 -0700
Subject: [PATCH] PCI: Add pci=safemode option
In-Reply-To: <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
 <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
Message-ID: <20180530073735.GA28793@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 09:41:33PM -0700, Sinan Kaya wrote:
> Bjorn and I discussed the need for such a "safe" mode feature when you
> want to bring up PCI for a platform. You want to turn off everything as
> a starter and just stick to bare minimum.

Can we please make it a config option the instead of adding code
to every kernel?  Also maybe the bringup should be in the name
to make this more clear?
