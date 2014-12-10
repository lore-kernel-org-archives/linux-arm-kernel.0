From: balbi@ti.com (Felipe Balbi)
Date: Wed, 10 Dec 2014 08:48:55 -0600
Subject: [RFC/PATCH 4/7] arm: omap: device: add support for generating
 sysconfig data from DT
In-Reply-To: <54882522.20002@ti.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-5-git-send-email-balbi@ti.com>
 <54882522.20002@ti.com>
Message-ID: <20141210144855.GB4602@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

adding linux-omap back

On Wed, Dec 10, 2014 at 04:19:06PM +0530, Lokesh Vutla wrote:
> > +	switch (prop) {
> > +	case 2:
> > +		sysc->sysc_fields = &omap_hwmod_sysc_type2;
> > +		break;
> > +	case 3:
> > +		sysc->sysc_fields = &omap_hwmod_sysc_type3;
> > +		break;
> > +	case 1:
> > +	default:
> > +		sysc->sysc_fields = &omap_hwmod_sysc_type1;
> > +	}
> Missed hooking the class to oh?
> 	class->sysc = sysc;

yeah, I'll fix that.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141210/49812e9a/attachment.sig>
