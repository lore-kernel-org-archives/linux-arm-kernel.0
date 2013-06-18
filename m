From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 17:39:38 -0300
Subject: [PATCH v3 05/12] ARM: mvebu: Remove the harcoded BootROM window
 allocation
In-Reply-To: <20130618201021.GA11688@obsidianresearch.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618173906.GC2204@obsidianresearch.com>
 <20130618194330.GA2394@localhost>
 <20130618195111.GC6578@obsidianresearch.com>
 <20130618200240.GB2470@localhost>
 <20130618201021.GA11688@obsidianresearch.com>
Message-ID: <20130618203937.GA2516@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 02:10:21PM -0600, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2013 at 05:02:42PM -0300, Ezequiel Garcia wrote:
> > > Having the kernel enforce that the DT node is present and at the right
> > > location, I think, is helpful for the bootloader folks to ensure they
> > > write correct DTs.
> 
> > Granted. But then I wonder... why do we bother to put the BootROM in the
> > DT window if we're going to check for a fixed address it in any case?
> 
> Code re-use in the mbus driver?
> 
> Maybe future SOCs in this family will have programmable SMP startup
> addresses?
> 
> Non-SMP systems don't need to map the boot rom at all?
> 

Three great answers :)

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
