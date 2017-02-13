From: wxf.wang@hisilicon.com (Wangxuefeng (E))
Date: Mon, 13 Feb 2017 08:04:03 +0000
Subject: Question about PTE_CONT in linux_4.10
Message-ID: <B99C36949BCC8541A564076B659DD9706714ED6D@nkgeml514-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

	I has a question about change access permission(X-executable) in linux_4.10 when continuous bit enable.
	In linux_4.10, the memories allocated by kmalloc are always set PTE_PXN and PTE_CONT. When I need change the access permission of the kmalloc area to make it has executable permission(clear PXN), what interface can I use?
    The set_memory_x only change the PTE_PXN, but it doesn't change continuous bit. If only a 4K page change the permission, TLB conflict will happen. Is there any other interface can change the permission?

Thanks,
Xuefeng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
