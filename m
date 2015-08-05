From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 5 Aug 2015 20:04:19 +0200
Subject: [PATCH v2 1/2] power: reset: at91: add sama5d3 reset function
In-Reply-To: <55B72EEA.5020600@atmel.com>
References: <1437384726-24927-1-git-send-email-josh.wu@atmel.com>
 <20150720164241.GA5930@earth> <55B72EEA.5020600@atmel.com>
Message-ID: <20150805180419.GA11315@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Tue, Jul 28, 2015 at 09:27:38AM +0200, Nicolas Ferre wrote:
> >> This patch introduces a new compatible string: "atmel,sama5d3-rstc" and
> >> new reset function for sama5d3 and later chips.
> > 
> > queued.
> 
> As my Device Tree changes depend on this modification,
> we can synchronize in tree ways:

Sorry for the delay.

> 1/ you provide me a stable branch so that I can pull it before applying
> my changes that can go through arm-soc.
> 
> 2/ you let me take the driver's modifications with me and the two
> patches of the series would go through arm-soc.
>
> 3/ you take the second patch of my series with my Acked-by tag and carry
> both of them up to Linus' tree.

I would be fine with all solutions, but 2/ would also require
you handling another patch. I think your option 4/ is the best:

> Okay, so to ease synchronization, I take this one with me through
> arm-soc and add the old compatibility string as a fallback => the
> newer will be used when merged...

FWIW:

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150805/b46ff934/attachment.sig>
