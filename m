From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 13 Apr 2016 18:14:50 +0200
Subject: [PATCH v5 00/52] mtd: rework ECC layout definition
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160413181450.449634a5@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Mar 2016 18:14:15 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> Hopefully the last version of this patchset (but don't be sad, I'm not
> done bothering you with NAND related patches :-)).
> 
> If possible, I'd like to have as much Tested/Reviewed/Acked-by tags as
> possible, particularly on the changes done in arch/arm and arch/mips
> (since the last set of commits depends on those changes, I'd like to
> take them in my nand/next branch, even if this imply creating an
> immutable branch for the ARM and MIPS maintainers).

It's been around for quite some time now, and got several
Acked/Tested/Reviewed-by tags. Let's push that on nand/next and see if
someone complains in which case I drop those patches before sending my
PR to Brian.

Thanks for your reviews.

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
