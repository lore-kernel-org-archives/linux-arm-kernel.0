From: awallis@codeaurora.org (Adam Wallis)
Date: Thu, 30 Nov 2017 12:52:46 -0500
Subject: [PATCH v2] usb: xhci: allow imod-interval to be configurable
In-Reply-To: <ffa34aa3-0a1f-ba85-e7ba-356bdffa4e5a@linux.intel.com>
References: <1511970775-11103-1-git-send-email-awallis@codeaurora.org>
 <20171129174619.GB22267@kroah.com>
 <ffa34aa3-0a1f-ba85-e7ba-356bdffa4e5a@linux.intel.com>
Message-ID: <efe543b5-fbb1-7438-d20e-bf5ba190c761@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2017 3:41 AM, Mathias Nyman wrote:
[..]
> I do however mind that I don't get any default imod interval value for my
> pci based xhci host after this patch.
> That needs to be fixed
> 

Thanks Mathias, good catch. Where do you think I should initialize imod default
in PCI subsytem? I was thinking about in xhci_pci_setup but would like to hear
your thoughts since I deal much less often with USB PCI.

> Thanks
> -Mathias
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Adam

-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
