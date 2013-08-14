From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Aug 2013 11:03:14 +0100
Subject: [PATCH V4 0/4] Add i2s support on smdk5420
In-Reply-To: <6538092.D4LPomiMyc@flatron>
References: <1376300994-1679-1-git-send-email-padma.v@samsung.com>
 <20130813124440.GX6427@sirena.org.uk> <6538092.D4LPomiMyc@flatron>
Message-ID: <20130814100314.GN6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 10:25:27AM +0200, Tomasz Figa wrote:

> Hmm, this series looks good to me too, except one thing. What about the 
> bisection breakage introduced by the hole between patches 1/4 and 4/4 
> (after the list of supported compatible changes in the driver and before 
> respective dts files are updated)?

It's annoying but relatively localised and obvious rather than the cross
tree stuff that happens so frequently with these platforms.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130814/525e0a3c/attachment.sig>
