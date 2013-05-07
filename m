From: itooo@itooo.com (Greg)
Date: Tue, 07 May 2013 16:14:01 +0200
Subject: MVNETA irq with backport-3.8
Message-ID: <51890C29.8000504@itooo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, Willy,

I'm trying to boot off the the backport-3.-8 kernel with armada-xp-db DT 
file.

When eth0 is brought up (I'm booting on NFS) the mvneta driver fails in 
mvneta_open, with the following error :
> mvneta d0070000.ethernet eth0: cannot request irq 25

The oddness is this is not the actual IRQ to be requested, and the DTS 
files explicitly specify the IRQ is 8 for this device.

I'm not familiar with the DT system, where should I start looking to 
find the source of the problem ?

Thanks!
