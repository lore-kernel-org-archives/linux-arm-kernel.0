From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 22 Jan 2014 17:26:41 -0500
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <87bnz364h0.fsf@natisbad.org>
References: <87bnzekz5l.fsf@natisbad.org>
 <063D6719AE5E284EB5DD2968C1650D6D45C5AB@AcuExch.aculab.com>
 <87mwix5anm.fsf@natisbad.org> <20140116185044.GC18392@xanatos>
 <87fvon2khn.fsf@natisbad.org> <87zjmvau23.fsf@nemi.mork.no>
 <20140117205432.GB5618@xanatos> <87vbxhrmea.fsf@natisbad.org>
 <20140121211741.GA12657@xanatos> <87bnz364h0.fsf@natisbad.org>
Message-ID: <20140122222641.GD29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 11:23:23PM +0100, Arnaud Ebalard wrote:
> With the patch applied on top of 3.13.0 kernel recompiled w/
> CONFIG_PCI_MSI enabled, I cannot reproduce the bug. I guess
> you can add my:
> 
>  Reported-and-tested-By: Arnaud Ebalard <arno@natisbad.org>
> 
> Since you'll have to push the patch to -stable team at least for 3.13,
> I wonder if it would not make sense to extend that at least to 3.12.
> and possibly 3.10 (3.2 is still widely used but I wonder if it makes
> sense to go that far).

Can you pinpoint the commit that introduced the regression?

thx,

Jason.
