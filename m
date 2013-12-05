From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 05 Dec 2013 01:47:04 +0100
Subject: [PATCH 1/2] regulator: gpio-regulator: Add required
 regulator-type property
In-Reply-To: <20131205000928.GI29268@sirena.org.uk>
References: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385653493-9952-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131205000928.GI29268@sirena.org.uk>
Message-ID: <2248657.5UVkYxaC6z@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thursday 05 December 2013 00:09:28 Mark Brown wrote:
> On Thu, Nov 28, 2013 at 04:44:52PM +0100, Laurent Pinchart wrote:
> > The gpio-regulator driver requires the regulator-type property to be
> > present. Document it as required in the DT bindings.
> 
> It does?  That seems needless.  It should just default to voltage and
> provide a way override to current, though frankly I'd be astonished to see a
> GPIO controlled current regulator at all so I'm not sure I'd even bother
> writing the code for that until someone needs it.  As it is this will most
> likely just be noise in the DT files and wasted cycles parsing the property.

I'm fine with that. The property should still be documented in the DT bindings 
as optional though. Or be removed completely until a GPIO-controlled current 
regulator is needed.

> Please CC maintainers...

My bad, sorry.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131205/410b02e8/attachment-0001.sig>
