From: john.ogness@linutronix.de (John Ogness)
Date: Fri, 18 Jun 2010 18:58:59 +0200
Subject: [PATCH 0/5] mtd: mxc_nand fixups
Message-ID: <80ljacb7l8.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following 5 patches fix several issues with the MXC NFC
driver. These changes were tested using an i.MX35 with a 16-bit flash
chip (2K pages, 64 pages per eraseblock).

Many of the changes are sitting behind a nfc_is_v21() check because I do
not know if the older NAND controllers are the same.

John Ogness
