From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Tue, 15 Nov 2011 19:39:51 -0500
Subject: [PATCH/RESEND #3 5/7] arm: omap: smartreflex: clean ups all over
In-Reply-To: Your message of "Tue, 15 Nov 2011 10:46:03 +0200."
 <1321346765-16633-6-git-send-email-balbi@ti.com>
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
 <1321346765-16633-6-git-send-email-balbi@ti.com>
Message-ID: <22157.1321403991@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Nov 2011 10:46:03 +0200, Felipe Balbi said:

> -	int				srid;
> -	int				ip_type;
> +	struct list_head		node;
> +	struct platform_device		*pdev;
> +	struct omap_sr_nvalue_table	*nvalue_table;
> +	struct voltagedomain		*voltdm;

As long as you're de-tabifying the function names that caused the problem...

>  	int				nvalue_count;
> -	bool				autocomp_active;
> -	bool				is_suspended;

Why are you leaveing the rest of the struct tabified out to East Podunk?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111115/e07b4607/attachment.sig>
