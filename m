From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Apr 2013 15:33:31 +0100
Subject: [PATCHv8 07/19] arm: pci: add a align_resource hook
In-Reply-To: <20130415163609.GJ28693@titan.lakedaemon.net>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1365541601-14095-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130415163609.GJ28693@titan.lakedaemon.net>
Message-ID: <20130419143331.GV14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 12:36:09PM -0400, Jason Cooper wrote:
> Russell,
> 
> Thanks for applying this patch (7683/1) to your tree.  I see it's in
> your for-next, which I understand *isn't* stable.

That is correct.

>   029baf1 ARM: 7683/1: pci: add a align_resource hook
> 
> Is there a stable branch I could depend on for the rest of this series
> (particularly, patch 10)?  It looks like you applied it to your misc
> branch, but that's not currently available.

I will have to look at that; as I'm still catching up with mail three
days after having returned and there's still quite an amount outstanding,
it's going to be a while before I can look at this.  Given that we're at
-rc7 and the amount of outstanding mail, it's likely that may happen
after the merge window has opened.
