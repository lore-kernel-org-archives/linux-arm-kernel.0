From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 3 May 2010 11:28:41 +0300
Subject: [PATCH 0/8] Initial implementation of kdump for ARM
In-Reply-To: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <20100503082841.GO26418@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 20, 2010 at 11:50:46AM +0300, Mika Westerberg wrote:
> 
> This is revised series of kdump code, now without "RFC"-prefix. Original
> series can be found here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/012353.html
> 
> Changes to previous version:
> 	- crash_setup_regs() uses Russell's suggestion for saving registers
> 	- copy_oldmem_page() code is changed to use ioremap()
> 	- there is no need for special 'mem=' parameters
> 
> I've been testing this on my N900.

Hi Russell,

Do have any comments on these patches? Any objections for sending
these to your patch tracking system?

I've also tested these on beagleboard and it works there as well.

Thanks,
MW
