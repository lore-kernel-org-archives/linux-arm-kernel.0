From: horms@verge.net.au (Simon Horman)
Date: Tue, 11 Jun 2013 16:56:27 +0900
Subject: [PATCH v9 resend 0/3] Add USB support to R8A7778/BOCK-W
In-Reply-To: <20130611074959.GG10440@verge.net.au>
References: <201306090032.35128.sergei.shtylyov@cogentembedded.com>
 <20130611074959.GG10440@verge.net.au>
Message-ID: <20130611075627.GB5300@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 04:49:59PM +0900, Simon Horman wrote:
> On Sun, Jun 09, 2013 at 12:32:34AM +0400, Sergei Shtylyov wrote:
> > Hello.
> > 
> >    Here's the set of 3 patches against the Simon Horman's 'renesas.git' repo,
> > 'renesas-next-20130607' tag, and the R8A7779/Marzen USB patchset I've posted.
> > It was created to add support of R8A7778/BOCK-W USB to the platform code and
> > the USB common PHY driver, and so spans both arch/arm/mach-shmobile/ and
> > drivers/usb/phy/ subtrees.
> > 
> > [1/3] phy-rcar-usb: add R8A7778 support
> > [2/3] ARM: shmobile: r8a7778: add USB support
> > [3/3] ARM: shmobile: BOCK-W: add USB support
> > 
> >    The patchset is completely ready for merging now.
> 
> Thanks, I have queued this up in the soc2 phy-rcar-usb.

s/soc2 phy-rcar-usb/phy-rcar-usb branch/

> My current plan is to let that branch sit in next for a few
> days and then send a pull-request for it to be included in v3.11.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
