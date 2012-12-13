From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Dec 2012 09:33:50 +0900
Subject: [PATCH v2] ARM: shmobile: r8a7779: Fix GPIO input reg addresses
In-Reply-To: <OF613746CC.4E3EB4D0-ON80257AD2.0038052F-80257AD2.00381232@eu.necel.com>
References: <16942826.W5hEBZUpzF@avalon>
 <1355225657-18731-1-git-send-email-phil.edworthy@renesas.com>
 <2861660.bMP77HcQxX@avalon>
 <OF613746CC.4E3EB4D0-ON80257AD2.0038052F-80257AD2.00381232@eu.necel.com>
Message-ID: <20121213003350.GG13343@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 10:12:27AM +0000, phil.edworthy at renesas.com wrote:
> Hi Simon, Laurent,
> 
> (resend as plain text)
> 
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > To: Phil Edworthy <phil.edworthy@renesas.com>, 
> > Cc: Simon <horms@verge.net.au>, linux-sh at vger.kernel.org, linux-arm-
> > kernel at lists.infradead.org, Magnus <magnus.damm@gmail.com>, Laurent 
> > Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Date: 11/12/2012 11:39
> > Subject: Re: [PATCH v2] ARM: shmobile: r8a7779: Fix GPIO input reg 
> addresses
> > 
> > On Tuesday 11 December 2012 11:34:17 Phil Edworthy wrote:
> > > The INDTx register addresses were wrong.
> > > 
> > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > 
> > You can add
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Please scrap this patch. I just found out that it screws up the GPIO 
> outputs. The current code assumes the same register is used for both input 
> and output, which is not the case. It needs a bit of work to fix this.

Thanks, I have marked v1 and v2 as Rejected in patchwork.
