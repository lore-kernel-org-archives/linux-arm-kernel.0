From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 18 Dec 2015 17:04:13 +0200
Subject: OMAP display kconfig options changing
In-Reply-To: <CAHCN7xJnHac+50TFSZ-+4Hqq9Of1HA6fTtnPxKUMCq_j5_UqgQ@mail.gmail.com>
References: <5673CA0D.4000706@ti.com> <20151218135342.GF23396@atomide.com>
 <CAHCN7xJnHac+50TFSZ-+4Hqq9Of1HA6fTtnPxKUMCq_j5_UqgQ@mail.gmail.com>
Message-ID: <5674206D.60207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/12/15 16:03, Adam Ford wrote:
> Tomi,
> 
> I'd like to also test the LogicPD Torpedo which has been using the FB
> drivers until this point. I just pushed some LCD info for inclusion in
> 4.5, but if I need to make changes, I'd like to do that sooner than

The DT data is the same for omapfb and omapdrm, so no changes needed.

> later.  Any insturctions would be helpful.  Will this impact people
> who use the SGX drivers?

I'm no expert, but... Yes, I think so. If you were using SGX driver with
some additional omapfb patches, it won't work with omapdrm.

omapdrm + SGX works, but it's a bit tricky setup (need extra kernel
patches, specific userspace libs...). I hope we'll get the SGX side
sorted out during the first quarter, which should make omapdrm + SGX
much easier to get running.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151218/f2417bea/attachment-0001.sig>
