From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 14 Apr 2017 15:10:02 -0400
Subject: [PATCH V8 2/5] PCI/ASPM: split pci_aspm_init() into two
In-Reply-To: <CAErSpo4gduGVq2Na0tYbG77Pi23R-RMBvAcJueWrQTJCRsHYGw@mail.gmail.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-3-git-send-email-okaya@codeaurora.org>
 <CACK8Z6EfUTDjCM=fmdHfWeu8UV5GN+i6PX9fKkR1H8K90TXozg@mail.gmail.com>
 <CAErSpo4gduGVq2Na0tYbG77Pi23R-RMBvAcJueWrQTJCRsHYGw@mail.gmail.com>
Message-ID: <04c89a56-5e33-22e7-8665-cd94ac56d920@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2017 2:25 PM, Bjorn Helgaas wrote:
> I agree, and I made that change on my branch.  I also renamed these to
> pci_aspm_init_downstream_port() (for Root Ports and Switch Downstream
> Ports) and pci_aspm_init_upstream_port() (for Switch Upstream Ports
> and Endpoints) to try to match the terminology in the spec.

OK. I reordered and renamed the functions according to your suggestions
on my local copy too.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
