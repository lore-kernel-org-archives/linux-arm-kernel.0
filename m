From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 26 Jan 2014 14:30:19 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <87sisfjeba.fsf@natisbad.org>
References: <87mwix5anm.fsf@natisbad.org> <20140116185044.GC18392@xanatos>
 <87fvon2khn.fsf@natisbad.org> <87zjmvau23.fsf@nemi.mork.no>
 <20140117205432.GB5618@xanatos> <87vbxhrmea.fsf@natisbad.org>
 <20140121211741.GA12657@xanatos> <87bnz364h0.fsf@natisbad.org>
 <20140122222641.GD29184@titan.lakedaemon.net>
 <87mwin4ozf.fsf@natisbad.org> <20140122235620.GC20359@xanatos>
 <87sisfjeba.fsf@natisbad.org>
Message-ID: <20140126143019.09d0b9e0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnaud Ebalard,

On Thu, 23 Jan 2014 09:24:41 +0100, Arnaud Ebalard wrote:

> The various Armada-based devices I have are NAS which do not have PCIe
> slots to plug additional devices (everything is soldered). I don't know
> which device Thomas used for its tests. Just in case, I also added Willy
> in CC: who have various boards and may also have done more test with
> additional PCIe devices and CONFIG_PCI_MSI enabled on 3.13 kernel.

The device I've used to test MSI is a e1000e PCIe Intel network card.
It uses one MSI interrupt, so admittedly, the MSI testing is quite
limited for now.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
