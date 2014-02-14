From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 14 Feb 2014 09:26:06 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <20140214000910.GB16889@xanatos>
References: <87fvon2khn.fsf@natisbad.org> <87zjmvau23.fsf@nemi.mork.no>
 <20140117205432.GB5618@xanatos> <87vbxhrmea.fsf@natisbad.org>
 <20140121211741.GA12657@xanatos> <87bnz364h0.fsf@natisbad.org>
 <20140122222641.GD29184@titan.lakedaemon.net>
 <87mwin4ozf.fsf@natisbad.org> <20140122235620.GC20359@xanatos>
 <87wqh2iymx.fsf@natisbad.org> <20140214000910.GB16889@xanatos>
Message-ID: <20140214092606.7db96949@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sarah, Arnaud,

On Thu, 13 Feb 2014 16:09:10 -0800, Sarah Sharp wrote:

> > Unless you have some objections or some positive feedback from Fresco
> > Logic people, can you queue your quirks for FL1009 for 3.14-rc* and
> > -stable? Note that I am just asking, i.e. if you want to wait a bit
> > more, I am not that in a hurry.
> 
> Sorry for not getting back to you sooner.  The Fresco Logic folks said
> that the FL1000 and FL1400 hosts are actually the same chipset, and it
> doesn't support MSI.  However, they say the FL1009 *should* support MSI.
> 
> So that doesn't rule out issues with the Marvell PCI MSI code.  I
> suspect that's actually the root cause, since I haven't gotten any bug
> reports that the FL1009 doesn't work with MSI enabled on other systems.

Ok, I'll try to have a look into this, by re-reading the entire
thread, and trying to propose some patches that add debugging details
in the Marvell PCI MSI code to try to understand what's going on.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
