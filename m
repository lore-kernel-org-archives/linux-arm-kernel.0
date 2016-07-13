From: shhuiw@foxmail.com (=?gb18030?B?V2FuZyBTaGVuZy1IdWk=?=)
Date: Wed, 13 Jul 2016 14:10:04 +0800
Subject: about the patch " [v2] arm64: pci: add support for
 pci_mmap_page_range"
Message-ID: <tencent_450FC44868A4D84249E2AB9D@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerin & Will,

Sorry to trouble you!

I found your patch https://patchwork.codeaurora.org/patch/2059/ and thought it's
helpful as many dev tools will access the resourceX file for different devices/drivers, 
e.g nvme-cli for NVMe.

As for the ?legacy /proc interface?, I think it should be another topic: you have to
modify the proc for pci and handle various tools broken. But for exposing resourceX, it does work. 
I wonder why this patch is not accepted into upstream? Or newer version is available?


------------------
Regards,
Wang Sheng-Hui
