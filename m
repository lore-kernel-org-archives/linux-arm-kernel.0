From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 24 Nov 2017 15:58:45 +0100
Subject: [PATCH V2 23/29] staging: rts5208: deprecate
 pci_get_bus_and_slot()
In-Reply-To: <1511390964-9979-24-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
 <1511390964-9979-24-git-send-email-okaya@codeaurora.org>
Message-ID: <20171124145845.GA18443@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 05:49:18PM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Remove unused rtsx_read_pci_cfg_byte() function.

You only need this one sentance here for the changelog for this patch.
And the subject line makes no sense.

Please fix up and resend.

thanks,

greg k-h
