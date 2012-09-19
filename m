From: balbi@ti.com (Felipe Balbi)
Date: Wed, 19 Sep 2012 15:01:56 +0300
Subject: [PATCH v2 RESEND] USB: chipidea: convert to use devm_request_irq
In-Reply-To: <20120919013248.GG13530@b20223-02.ap.freescale.net>
References: <1348017626-6570-1-git-send-email-richard.zhao@freescale.com>
 <201209190330.41648.marex@denx.de>
 <20120919013248.GG13530@b20223-02.ap.freescale.net>
Message-ID: <20120919120155.GK3772@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 09:32:49AM +0800, Richard Zhao wrote:
> On Wed, Sep 19, 2012 at 03:30:41AM +0200, Marek Vasut wrote:
> > Dear Richard Zhao,
> > 
> > You know, commit message would be nice to have.
> Yes, but for this one, the title shows obviously what it changed,
> doesn't it?

Alex has the the final word, but I'm also very picky about commit
messages. IMHO, all patches should have commit message, even if it
sounds obvious.

For example, you could let us know the reasoning behind converting to
devm_request_irq().

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120919/cd4cf30e/attachment.sig>
