From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 29 May 2018 21:36:15 -0700
Subject: [PATCH] PCI: move early dump functionality from x86 arch into the
 common code
In-Reply-To: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
References: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
Message-ID: <dc9133a4-7085-e663-172a-87601ee8775d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/29/2018 9:34 PM, Sinan Kaya wrote:
> -int early_pci_allowed(void)
> -{
> -	return (pci_probe & (PCI_PROBE_CONF1|PCI_PROBE_NOEARLY)) ==
> -			PCI_PROBE_CONF1;
> -}

I should have kept this. I'll wait for more feedback before posting the
next rev. 

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
