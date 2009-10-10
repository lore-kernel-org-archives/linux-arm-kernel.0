From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Sat, 10 Oct 2009 16:41:33 +0100
Subject: 2.6.32-rc3/sparsemem: kernel BUG at mm/bootmem.c:243
In-Reply-To: <4AD051D1.8060001@gmail.com>
References: <4ACFC458.7080307@techworks.ie> <4AD051D1.8060001@gmail.com>
Message-ID: <4AD0AB2D.9000307@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matthieu Crapet wrote:
> Hi Christian,
> 
> It works fine here with my TS-7250. I'll send you asap my "ts72xx rebase 

Matthieu,

Has your TS-7250 64MB? Are you using sparsemem or flatmem?

7250: 1x32MB at 0x00000000, using flatmem or sparsemem, always OK
7260: 1x32MB at 0x00000000, 32MB at 0xe0000000, using sparsemem, not OK 
anymore (was OK with 2.6.32-rc2)
Hartley: 1x64MB at 0x00000000, using flatmem, OK

Btw Hartley, which board are you using for testing?

I'll check again the meminfo with 2.6.32-rc3, I did it for 2.6.32-rc2 
and it showed 8 nodes of 8MB, each at the expected base addresse, as I 
didn't change my bootloader I should still get the same result, let's see.

Regards,
Chris
