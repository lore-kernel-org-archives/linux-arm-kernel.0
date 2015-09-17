From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Sep 2015 20:27:37 +0200
Subject: [PATCH v8 0/4] can: Allwinner A10/A20 CAN Controller support -
 Summary
In-Reply-To: <55FB028F.7070206@hartkopp.net>
References: <1442402482-7118-1-git-send-email-info@gerhard-bertelsmann.de>
 <20150917175444.GJ4684@lukather> <55FB028F.7070206@hartkopp.net>
Message-ID: <20150917182737.GK4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 08:12:31PM +0200, Oliver Hartkopp wrote:
> 
> 
> On 17.09.2015 19:54, Maxime Ripard wrote:
> >On Wed, Sep 16, 2015 at 01:21:18PM +0200, Gerhard Bertelsmann wrote:
> >>Hi,
> >>
> >>please find attached the next version of my patch set. I have
> >>taken all remarks from Maxime Ripard into the new version
> >>
> >>Please review, test and report bugs if exists.
> >>
> >>The patchset applies to all recent Kernel versions (4.x, next etc.).
> >>
> >>[PATCH v8 1/4] Device Tree Binding Documentation
> >>[PATCH v8 2/4] Defconfig multi_v7
> >>[PATCH v8 3/4] Defconfig sunxi
> >>[PATCH v8 4/4] Kernel Module
> >
> >Applied 3 and 4.
> 
> Applied to what tree?
> 
> That's not the friendly way when Marc asks you about the documentation about
> the device tree (patch 1) and you commit the CAN driver and the sunxi
> defconfig (patch 3 & 4) that he mainly reviewed to whatever tree.
> 
> New CAN drivers go via can-next and net-next into mainline.
> 
> So please answer Marcs question and let him queue up the CAN driver via
> can-next himself.

Hmmm, actually, I meant 2 and 3, the two defconfig patches.

The driver and bindings should of course go through Marc's tree.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150917/a7dd44e1/attachment.sig>
