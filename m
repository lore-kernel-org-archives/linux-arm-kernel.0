From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 21 Nov 2012 16:12:09 +0100
Subject: [PATCHv9 1/3] Runtime Interpreted Power Sequences
In-Reply-To: <CAAVeFuJofYwj926=3v0ApBCq_vNhCdC1PnzDc-B3d=LL_L40Uw@mail.gmail.com>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121120215429.B621F3E1821@localhost>
 <13540495.epaCf4JVn9@percival> <50ACB59B.4090404@iki.fi>
 <20121121114018.GA31576@avionic-0098.adnet.avionic-design.de>
 <50ACC341.3090204@ti.com>
 <20121121130039.GA12191@avionic-0098.adnet.avionic-design.de>
 <50ACD7DC.5060405@ti.com>
 <CAAVeFuJofYwj926=3v0ApBCq_vNhCdC1PnzDc-B3d=LL_L40Uw@mail.gmail.com>
Message-ID: <20121121151209.GA4048@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 12:02:47AM +0900, Alexandre Courbot wrote:
> Mmmm so maybe I am misinterpreting things, but it looks like we
> have just buried the power sequences here, haven't we?

I don't think so. In fact I was just starting to think that maybe for
Tegra we could have a generic panel driver which used power sequences
to abstract away the pin differences for powering up the panel. Since
most likely that will be where the differences are there is a lot of
potential to factor things out into sequences.

Perhaps what we may want to postpone for now is the DT representation
since that's what Tomi and Grant seem to be mostly opposed to.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121121/5df0a721/attachment.sig>
