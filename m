From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue, 7 Oct 2014 11:37:17 +0100
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <2257006.dpJJ6zLgnP@avalon>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
 <2257006.dpJJ6zLgnP@avalon>
Message-ID: <20141007113717.d8dcc5607caf23971ec06c9d@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be fair, my patches were in last month, and awaiting a chance to test on Rcar-H1...

Can we share credit (Signed-off-by:) on the core, lager, 7779, and Kconfig patches please?

Cheers guys :)

(Its been a crap year for me, I've had almost zero chance to mainline anything :( )

-Ian

On Mon, 06 Oct 2014 01:18 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Geert,
> 
> Thank you for the patch.
> 
> It looks like you've beaten Ian Molton (CC'ed) on this, he was planning to 
> send exactly the same thing.
> 
> On Thursday 02 October 2014 21:02:43 Geert Uytterhoeven wrote:
> > Add serial port debug macros for the SCIF(A) serial ports.
> > This includes all shmobile SoCs, except for EMEV2.
> > 
> > On SoCs using the legacy machine_desc.map_io(), an identity mapping of
> > the SCIF(A) registers must be set up in .map_io(). On all but r8a7779
> > this was already done.
> > 

-- 
Ian Molton <ian.molton@codethink.co.uk>
