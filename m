From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 17 Dec 2013 23:12:58 -0800
Subject: [PATCH] Partially revert "mtd: nand: pxa3xx: Introduce
 'marvell,armada370-nand' compatible string"
In-Reply-To: <20131218004245.GB10369@localhost>
References: <1386624986-404-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131212230715.GX27149@ld-irv-0074.broadcom.com>
 <20131218004245.GB10369@localhost>
Message-ID: <20131218071258.GA5551@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On Tue, Dec 17, 2013 at 09:42:45PM -0300, Ezequiel Garcia wrote:
> Just to have some context, this compatible was removed because it was
> wrongly added and it doesn't belong at v3.12 and v3.13.
> 
> Now the revert is in place in v3.13-rc4 and it should be queued for
> v3.12.x, so we are good. Thanks for taking care of it!
> 
> On the other side, all the work needed for the driver to work OK on
> Armada 370/XP SoC is already in l2-mtd.git master, and I have some fixes
> ready to support 2048B pages.
> 
> In conclusion, I think it's safe to add the compatible on top of such work,
> and queue it for v3.14.

Let's get any last patches in, and add the compatible string last.
Please resend any remaining patches, since I think you have at least one
which you mislabeled as necessary for 3.13.

> How should I send a patch to re-add this compatible? Do you plan to rebase
> l2-mtd.git master on top of v3.13-rc4 or so?

l2-mtd.git is currently rebased on top of the last changes I sent to
Linus, so you can send any patches off the current tree. If I rebase
onto -rc4, that shouldn't make any difference to your changes.

Brian
