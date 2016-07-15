From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Fri, 15 Jul 2016 08:29:49 +0000
Subject: Memory and IO space Enabling different in x86 and ARM64
Message-ID: <8520D5D51A55D047800579B094147198258B9376@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I observe that memory and IO space are enabled by BIOS in x86.

In ARM64 we need to call pci_enable_device form End Point to enable these resources.

Why the resource enablement is different in x86 and ARM64 ?

Please correct me if my observation is wrong.

Thanks & Regards,
Bharat


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
