From: colin.tuckley@arm.com (Colin Tuckley)
Date: Wed, 22 Dec 2010 14:09:25 -0000
Subject: [PATCH 0/6] Add PCI support for ARM RealView boards
Message-ID: <000501cba1e1$d739bcf0$85ad36d0$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apologies for the empty header email for this series it should have said:

 

The following series implements the PCI support for the

ARM RealView NEC custom Northbridge based reference boards

(PBA8, PB11MPCore and PBX).

 

The boards have a PCIX root complex connected to PCI and

PCIe bridges. Each board has 2 PCI slots and 2 PCIe slots.

 

This is the second pass of posting these patches to the list - all previous
comments have been addressed.

 

Colin

 

 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101222/f1271460/attachment.html>
