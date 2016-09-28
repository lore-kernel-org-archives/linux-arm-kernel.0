From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Sep 2016 09:46:18 +0100
Subject: [PATCH 1/1] ARM: dma: fix dma_max_pfn()
In-Reply-To: <135ccf6f-ef3b-98a5-9d3d-4cd7f0967ceb@ti.com>
References: <1471435517-7840-1-git-send-email-rogerq@ti.com>
 <1471435517-7840-2-git-send-email-rogerq@ti.com>
 <20160818142459.GX1041@n2100.armlinux.org.uk>
 <8003b6ed-6071-9384-1b88-0b84604bdce8@oracle.com>
 <20160818230754.GE1041@n2100.armlinux.org.uk>
 <f8a05c02-df36-a0cf-6433-c67eb4a0f5b6@oracle.com>
 <9c38663b-1867-213d-21ba-f1dec7edfb6a@ti.com>
 <81dedbcc-14f6-f02f-2ce9-114d57c8d9d4@oracle.com>
 <c29290ee-9d74-73f9-7405-112357359f55@ti.com>
 <135ccf6f-ef3b-98a5-9d3d-4cd7f0967ceb@ti.com>
Message-ID: <20160928084618.GK1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2016 at 10:53:49AM +0300, Roger Quadros wrote:
> Hi,
> 
> On 12/09/16 14:38, Roger Quadros wrote:
> > Hi Santosh & Russell,
> > 
> > On 19/08/16 19:38, Santosh Shilimkar wrote:
> >>
> >> On 8/19/2016 12:30 AM, Roger Quadros wrote:
> >>> Hi Santosh,
> >>>
> >>
> >>>>> So I'm 99.9% convinced that the proposed change is correct.
> >>>>>
> >>>> I will got with that then :-) and take my objection back. Just
> >>>> saying that if there other breakages which I can't recollect now,
> >>>> those drivers needs to be patched as well.
> >>>>
> >>> I was able to boot the Keystone2 Edison EVM over NFS with the $subject patch.
> >>> Boot log is below. Do you see anything suspicious?
> >>>
> >> Logs looks ok to me. Probably do some tests where DMA and bounce buffers etc gets tested. Running it through your internal regression
> >> suit will be good idea as well if thats possible.
> >>
> > 
> > This has been running in our internal test suite for a week on various TI
> > platforms. There haven't been any surprises.
> > 
> > Is it a good idea to at least put this in -next for a wider test audience?
> 
> Gentle reminder.

Please put it in the patch system, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
