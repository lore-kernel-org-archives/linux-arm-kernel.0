From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 25 May 2018 09:30:59 -0400
Subject: [PATCH V2] PCI/portdrv: do not disable device on reboot/shutdown
In-Reply-To: <20180524183502.GB85822@bhelgaas-glaptop.roam.corp.google.com>
References: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
 <20180523213249.GD150632@bhelgaas-glaptop.roam.corp.google.com>
 <61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org>
 <20180524183502.GB85822@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <984b9734-244d-04e9-946f-7524f148ff7c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/24/2018 2:35 PM, Bjorn Helgaas wrote:
> That sounds like a reasonable idea, and it is definitely another can
> of worms.  I looked briefly at some of the .shutdown() cases:

should we throw it into 4.18 and see what happens?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
