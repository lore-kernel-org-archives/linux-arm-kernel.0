From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 10 Jan 2013 21:02:19 -0700
Subject: [PATCH 2/3] ARM: Orion: Bind the orion bridge interrupt
 controller through DT
In-Reply-To: <20130110185737.GO5075@titan.lakedaemon.net>
References: <1355188683-18208-2-git-send-email-jgunthorpe@obsidianresearch.com>
 <20121211062430.GD25466@lunn.ch>
 <20121211065813.GA14843@obsidianresearch.com>
 <20121211071333.GR17242@lunn.ch>
 <20121211185535.GA14534@obsidianresearch.com>
 <20130110014734.GC5075@titan.lakedaemon.net>
 <20130110060710.GM24650@lunn.ch> <50EE8FC5.50105@gmail.com>
 <20130110184832.GB28004@obsidianresearch.com>
 <20130110185737.GO5075@titan.lakedaemon.net>
Message-ID: <20130111040219.GA23206@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 01:57:37PM -0500, Jason Cooper wrote:
> Jason,
> 
> On Thu, Jan 10, 2013 at 11:48:32AM -0700, Jason Gunthorpe wrote:
> > There is a bunch of prep stuff that may still be pending:
> >  - Fixup remaining drivers (usb? ethernet?) to have DT bindings and
> >    get the IRQ number through DT
> 
> any chance I could get you post your changes to the ethernet driver (DT
> bindings)?  iirc, you said you had based them off of Ian Molton's work.
> Even if you posted them RFC, it'd be a good place to start from,
> reignite conversation and so forth.

I've attached the main mv dt patch as a MIME, sorry for the
awkwardness, I am travelling and won't be available... Please feel free
to re-post/alter as necessary. As I said before, I'm not happy with
it because it doesn't follow the standard convention for MDIO phys.

Jason
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mv643xx.c-Add-basic-device-tree-support.patch
Type: text/x-diff
Size: 8357 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/4e6ac12c/attachment-0001.bin>
