From: napohybelskurwysynom2010@gmail.com (Zimny Lech)
Date: Thu, 21 Oct 2010 14:16:09 +0200
Subject: [RFC] Removal of dead code from arch/arm/*
In-Reply-To: <AANLkTimHWtJDV+ZkRnLY5sPmBGC-Z9wHaZwT2KBAN2nv@mail.gmail.com>
References: <AANLkTim+vj_OAd22TdThuC-HSqUiDjguOHQWjyqFaq6N@mail.gmail.com>
	<AANLkTi=Cpq2_vV2RGcoQhrqk8xpL59AvLFPzfvTBk5Xa@mail.gmail.com>
	<4CBF8BDB.7090907@gmail.com>
	<20101021075401.GC22100@n2100.arm.linux.org.uk>
	<AANLkTikjByC1_BQvPv=Stkdph1cV=a8CwcqrcBv6u0+p@mail.gmail.com>
	<AANLkTik=27zjJacQTQhd6E4rGuERg19rAd5cgnLTDEoR@mail.gmail.com>
	<AANLkTimHWtJDV+ZkRnLY5sPmBGC-Z9wHaZwT2KBAN2nv@mail.gmail.com>
Message-ID: <AANLkTim=vGmaBRBNtAAPhcZ8CfwCFSCm_0ewY78WHeaM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/21 Zimny Lech <napohybelskurwysynom2010@gmail.com>:

> Another one

drivers/scsi/qla4xxx/ql4_nx.c: In function ?qla4_8xxx_pci_mem_read_direct?:
drivers/scsi/qla4xxx/ql4_nx.c:716: error: implicit declaration of
function ?readq?
drivers/scsi/qla4xxx/ql4_nx.c: In function ?qla4_8xxx_pci_mem_write_direct?:
drivers/scsi/qla4xxx/ql4_nx.c:787: error: implicit declaration of
function ?writeq?


-- 
Slawa!
N.P.S.

Les fleurs du mal unfold
Comme les fleurs du mal
Dark demons of my soul
Un amour fatal
