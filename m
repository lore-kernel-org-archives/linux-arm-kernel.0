From: Colin.Tuckley@arm.com (Colin Tuckley)
Date: Tue, 20 Jul 2010 10:55:49 +0100
Subject: =?iso-8859-1?Q?RE:_[RFC]=A0arm:_versatile:_enable_PCI_I/O_space?=
In-Reply-To: <201007201123.38709.arnd@arndb.de>
References: <201007201123.38709.arnd@arndb.de>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA44DCF5AC89F@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Arnd Bergmann

> I believe I have found out what is actually going on with PCI I/O
> space mapping on the versatile platform, thanks to Catalin pointing
> me in the right direction.

These changes might also be applicable to PB1176 and EB which are built from the mach-realview sub-tree.

Note however that the pcix.c source file in that sub-tree is for the NEC Northbridge based boards (PB11MPCore, PBA8 and PBX). I'm not sure if the pci.c source file even exists in mach-realview.

Colin

--
Colin Tuckley - ARM Ltd.
110 Fulbourn Rd
Cambridge, CB1 9NJ
Tel: +44 1223 400536


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
