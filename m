From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 19 Mar 2015 09:42:24 +0000
Subject: [Linux-kernel] ATSAMA5D big endian work
In-Reply-To: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <550A9A00.9060808@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/15 15:52, Ben Dooks wrote:
> I have been testing the ATSAMA5D36 xplained board with big endian and
> the following are the fixes to get the system working.

As a note, I am still having issues with the macb driver (DMA HRESP
faults) which don't happen on the Xilinx version of this. Since I
have no data on the block I could do with some feedback from ATMEL
on this.

I still have yet to fix the NAND driver, but do not have any time
today to re-visit this.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
