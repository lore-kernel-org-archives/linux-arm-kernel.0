From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 Nov 2011 12:09:53 +0200
Subject: [PATCH/RESEND #3 5/7] arm: omap: smartreflex: clean ups all over
In-Reply-To: <22157.1321403991@turing-police.cc.vt.edu>
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
 <1321346765-16633-6-git-send-email-balbi@ti.com>
 <22157.1321403991@turing-police.cc.vt.edu>
Message-ID: <20111116100950.GA27980@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2011 at 07:39:51PM -0500, Valdis.Kletnieks at vt.edu wrote:
> On Tue, 15 Nov 2011 10:46:03 +0200, Felipe Balbi said:
> 
> > -	int				srid;
> > -	int				ip_type;
> > +	struct list_head		node;
> > +	struct platform_device		*pdev;
> > +	struct omap_sr_nvalue_table	*nvalue_table;
> > +	struct voltagedomain		*voltdm;
> 
> As long as you're de-tabifying the function names that caused the problem...
> 
> >  	int				nvalue_count;
> > -	bool				autocomp_active;
> > -	bool				is_suspended;
> 
> Why are you leaveing the rest of the struct tabified out to East Podunk?

de-tabifying ? I tabified the entire thing... Everything is aligned.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111116/f611e4aa/attachment.sig>
