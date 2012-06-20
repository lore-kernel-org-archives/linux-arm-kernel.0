From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 20 Jun 2012 16:50:36 -0700
Subject: [PATCH 2/2] serial: samsung: Fixed wrong comparison for
 baudclk_rate
In-Reply-To: <028f01cd4e9d$2b344410$819ccc30$%kim@samsung.com>
References: <000101cd3665$7943b690$6bcb23b0$%kim@samsung.com>
 <028f01cd4e9d$2b344410$819ccc30$%kim@samsung.com>
Message-ID: <20120620235036.GB8293@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 01:28:40PM +0900, Kukjin Kim wrote:
> Kyoungil Kim wrote:
> > 
> > port->baudclk_rate should be compared to the rate of port->baudclk,
> > because port->baudclk_rate was assigned as the rate of port->baudclk
> > previously.
> > So to check that the current baudclk rate is same as previous rate,
> > the target of comparison sholud be the rate of port->baudclk.
> > 
> > Signed-off-by: Jun-Ho, Yoon <junho78.yoon@samsung.com>
> > Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> 
> (Cc'ed Greg)
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Greg, this is needed to fix the wrong comparison for baudclk_rate for
> Samsung Serial.
> Could you please pick this up in your fix tree?

Already there, thanks.

greg k-h
