From: B19295@freescale.com (Lin Tony-B19295)
Date: Wed, 3 Aug 2011 02:06:04 +0000
Subject: [PATCH v2 1/1] ARM: mxc: fix card interrupt losing issue on
	freescale eSDHC
In-Reply-To: <m2ty9z73j6.fsf@bob.laptop.org>
References: <1311837360-16179-1-git-send-email-tony.lin@freescale.com>
	<1311837360-16179-2-git-send-email-tony.lin@freescale.com>
	<m2ty9z73j6.fsf@bob.laptop.org>
Message-ID: <97D3A72708D04647A5AC84A04996E5B5169802@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, Chris!

BR
Tony

> -----Original Message-----
> From: Chris Ball [mailto:cjb at laptop.org]
> Sent: Wednesday, August 03, 2011 8:16 AM
> To: Lin Tony-B19295
> Cc: linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 1/1] ARM: mxc: fix card interrupt losing issue on
> freescale eSDHC
> 
> Hi Tony,
> 
> On Thu, Jul 28 2011, Tony Lin wrote:
> > apply workaround for imx eSDHC controller to avoid missing the card
> > interrupt so that SDIO function is workable
> >
> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
> 
> Thanks, pushed to mmc-next for 3.1.
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
