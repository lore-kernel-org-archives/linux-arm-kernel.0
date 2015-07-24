From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 24 Jul 2015 10:27:51 +0200
Subject: [PATCH v11] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20150721125014.GA25272@gondor.apana.org.au>
References: <1437143983-4479-1-git-send-email-clabbe.montjoie@gmail.com>
 <20150720081050.GB12908@gondor.apana.org.au>
 <20150720081836.GT28632@lukather>
 <20150720082057.GA13098@gondor.apana.org.au>
 <20150721123847.GD2373@lukather>
 <20150721125014.GA25272@gondor.apana.org.au>
Message-ID: <20150724082751.GC2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 08:50:14PM +0800, Herbert Xu wrote:
> On Tue, Jul 21, 2015 at 02:38:47PM +0200, Maxime Ripard wrote:
> > I thought you needed at least my Acked-by for that, but
> > whatever... How are we supposed to handle subsequent DT patches that
> > should be merged through arm-soc then?
> 
> What subsequent patches are you referring to? The changes in
> this series are fairly self-contained so it should be unlikely
> to cause serious merge conflicts.

Enabling it in other boards / SoCs, and/or any change that might
conflict with this one.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150724/5486ed59/attachment.sig>
