From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 26 Jul 2017 20:28:52 +0200
Subject: [PATCH 0/3] memory: atmel-ebi: Fix setting EBI timings through dts
In-Reply-To: <1500984024-26403-1-git-send-email-ada@thorsis.com>
References: <1500984024-26403-1-git-send-email-ada@thorsis.com>
Message-ID: <20170726202852.4ffd01c2@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 25 Jul 2017 14:00:21 +0200,
Alexander Dahl <ada@thorsis.com> a ?crit :

> Hello,
> 
> this small patch series based on v4.13-rc2 fixes three things I found
> when trying to run the latest rc on an at91samg20 based platform with
> a SRAM like memory connected to the EBI interface, for which the
> timings should be set through dts. 
> 
> For all register settings of interest I checked the hardware manuals
> of the at91sam9g20 and the sama5d3x to not cause regressions, as well
> as the actual register settings in the running system. (I used the
> devmem tool from busybox for that.)

To the whole series:

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Alexandre, Nicolas, can you queue that for 4.13-rc3 or -rc4?
