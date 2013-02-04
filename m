From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 4 Feb 2013 16:29:15 -0300
Subject: [PATCH 0/2] ARM: mvebu: Add support for SPI controller in Armada
 370/XP
In-Reply-To: <20130204183733.GM14746@titan.lakedaemon.net>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130204165119.GA2440@localhost>
 <20130204183733.GM14746@titan.lakedaemon.net>
Message-ID: <20130204192914.GA2456@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Mon, Feb 04, 2013 at 01:37:33PM -0500, Jason Cooper wrote:
> This series looks good.  just a few comments:
> 
> On Mon, Feb 04, 2013 at 01:51:20PM -0300, Ezequiel Garcia wrote:
> > Hi,
> > 
> > This patchset adds support for the SPI controller
> > available in Armada 370 and Armada XP SoC.
> > 
> > The patches are based in Jason Cooper's mvebu/dt branch.
> 
> It probably doesn't matter for this series (I haven't tried to apply it
> yet), but please base future work off of a mainline tag (eg v3.8-rc6).
> It makes merge conflicts easier to resolve.
> 
> Feel free to test-merge against the mvebu/ branches and let me know of
> any conflicts.
> 

Ah, I see.

I was mistakenly assuming you wanted against that branch;
I'll base the patches on mainline in the future.

Thanks for the advice.

> Also, your patch series appears to be out of order, did you use git
> send-email once per file?
> 

I always send the cover letter manually. This time I did it after the patches.
I'm in the process of automating this in my workflow,
but feel free to make a suggestion.

Thanks,

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
