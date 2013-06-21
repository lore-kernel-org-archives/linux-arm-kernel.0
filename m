From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Jun 2013 10:47:04 +0100
Subject: [RFC PATCH 00/11] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <002501ce6da7$655924b0$300b6e10$%carmody@partner.samsung.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <20130619174047.GB1403@sirena.org.uk> <3697657.tZFV7pR81Q@flatron>
 <20130619192211.GH1403@sirena.org.uk>
 <001201ce6d98$03d9b920$0b8d2b60$%carmody@partner.samsung.com>
 <20130620103532.GA27646@sirena.org.uk>
 <002501ce6da7$655924b0$300b6e10$%carmody@partner.samsung.com>
Message-ID: <20130621094704.GJ27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 02:14:53PM +0300, Phil Carmody wrote:

> With my language-lawyer hat on, I'd suggest ``(get_signal)'' to prevent the
> macro expansion:

Right, which the patch I posted in the mail was doing IIRC.

> However, it's more tempting (i.e. sensible) to just rename the 
> one with the weaker claim to the name.

I sent a patch for that which Vinod has applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/5e0143f5/attachment.sig>
