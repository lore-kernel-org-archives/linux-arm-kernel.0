From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Sep 2015 09:12:53 -0700
Subject: [PATCH] ASoC: mediatek: Increase periods_min in capture
In-Reply-To: <1443002599.22786.2.camel@mtksdaap41>
References: <1442213477-63721-1-git-send-email-koro.chen@mediatek.com>
 <1443002599.22786.2.camel@mtksdaap41>
Message-ID: <20150923161253.GN30445@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 06:03:19PM +0800, Koro Chen wrote:
> Any suggestion for this patch?
> 
> On Mon, 2015-09-14 at 14:51 +0800, Koro Chen wrote:
> > In capture, there is chance that hw_ptr reported at IRQ is
> > a little smaller than period_size due to internal AFE buffer.
> > In the case of ping-pong buffer:

Please don't top post or send content free pings.  I'm not entirely sure
what you're asking for here - the patch has been applied, what further
suggestions were you looking for?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150923/0a40a3cf/attachment.sig>
