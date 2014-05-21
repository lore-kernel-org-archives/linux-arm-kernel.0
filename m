From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 21 May 2014 15:44:56 +0200
Subject: [PATCH 1/2] regulator: gpio-regulator: Add required
 regulator-type property
In-Reply-To: <20140513165921.GK12304@sirena.org.uk>
References: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2193707.R9XiqBsnU4@avalon> <20140513165921.GK12304@sirena.org.uk>
Message-ID: <1885616.D9TNdZVfuO@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 May 2014 17:59:21 Mark Brown wrote:
> On Tue, May 13, 2014 at 02:06:23AM +0200, Laurent Pinchart wrote:
> > What's the status of this ? The gpio regulator driver now defaults to
> > voltage regulator when the regulator-type property is not set. Should the
> > DT bindings document the property as optional (I can submit a patch for
> > that), or do you consider that the gpio regulator driver should support
> > voltage regulators only when used with DT, and just keep the
> > regulator-type property support in the driver for backward compatibility
> > ?
> 
> I don't really care either way, I did write a patch for the bindings but
> there was some language lawyering over it and I never cared enough to
> get round to updating it.

Could you please point me to the patch ?

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/2ea3bf88/attachment.sig>
