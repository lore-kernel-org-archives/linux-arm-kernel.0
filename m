From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jun 2014 17:01:19 +0100
Subject: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
In-Reply-To: <C3DA6AFC-2784-4A41-BC72-EF25B2B03B41@antoniou-consulting.com>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
 <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com>
 <20140617090931.GB3705@n2100.arm.linux.org.uk> <20140617125831.GI4173@beef>
 <20140617131522.GD3705@n2100.arm.linux.org.uk>
 <C3DA6AFC-2784-4A41-BC72-EF25B2B03B41@antoniou-consulting.com>
Message-ID: <20140617160119.GE3705@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 04:32:11PM +0300, Pantelis Antoniou wrote:
> The complexity is absolutely required, and it has nothing to do with
> beaglebone capes.
> 
> The fact of the matter is that reconfigurable hardware is here, on
> shipping system, and we, as the linux kernel community have to make
> sure it works, and that it works in a sane way.

Right, so looking back in the git history, this project has been going
on for... at least four years?  Probably longer than the length of time
that we've been converting ARM to DT.  At no point during that has anyone
brought up the issue of DT being dynamic, so none of the drivers which
we have been converting caters for this.

Isn't this a bit of a missed opportunity, if this is a direction that
OF wishes to head towards?

Wouldn't it have been relevant to the discussion at kernel summit too,
concerning DRM/v4l2/componentised systems?  What if someone comes along
tomorrow with part of their multimedia based system inside a FPGA
which they program up at runtime?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
