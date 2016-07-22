From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Fri, 22 Jul 2016 09:24:22 +0000
Subject: Why does BIOS assign memory to 16 byte BAR
Message-ID: <8520D5D51A55D047800579B094147198258BB59B@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm observing that on x86 BIOS successfully assigns memory if an End point requests
BAR of size 16byte.

But as per Spec:
The minimum memory address range requested by a BAR is 128 bytes.

Why BIOS is successfully allocating region to 16 byte BAR requests?

Please let me know if my observation is wrong.

Regards,
Bharat



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
