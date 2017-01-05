From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 4 Jan 2017 18:26:06 -0800
Subject: [PATCH 1/2] mfd: micon: Add Buffalo Kurobox Pro, Terastation II
 Pro/Live driver
In-Reply-To: <20170104112227.GA27589@dell>
References: <20161229000137.5553-1-f.fainelli@gmail.com>
 <20161229000137.5553-2-f.fainelli@gmail.com> <20170104112227.GA27589@dell>
Message-ID: <3e9b7bfe-8305-64fc-f175-e612576d58a7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/04/17 ? 03:22, Lee Jones a ?crit :
> On Wed, 28 Dec 2016, Florian Fainelli wrote:
> 
>> This driver is currently only used to reboot the devices, but the
>> microcontroller hanging off UART1 on the Buffalo Kurobox Pro and
>> Terastation II Pro/Live is capable of a lot more than that, which we
>> will support in subsequent patches. For now, just add the reboot
>> functionality to make the kernel reboot correctly.
> 
> This is not an MFD driver.  You have written a UART driver.
> 
> Please relocate it to drivers/char/tty/serial.

Not that simple, and as explained in the cover letter the UART attached
micro controller can do a lot more than just reboot the machine, but
someone else is working on the driver, so this patch series can be ignored.
-- 
Florian
