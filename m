From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 12 Sep 2012 11:15:03 -0700
Subject: [PATCH v2] /dev/mem: use phys_addr_t for physical addresses
In-Reply-To: <1347473158-7219-1-git-send-email-cyril@ti.com>
References: <1347473158-7219-1-git-send-email-cyril@ti.com>
Message-ID: <20120912181503.GB12840@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 02:05:58PM -0400, Cyril Chemparathy wrote:
> This patch fixes the /dev/mem driver to use phys_addr_t for physical
> addresses.  This is required on PAE systems, especially those that run
> entirely out of >4G physical memory space.

What is the symptom if this patch is not applied?  Does it need to be
backported to older kernels?  If so, which ones?

thanks,

greg k-h
