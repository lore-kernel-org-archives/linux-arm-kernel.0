From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 20 Jun 2012 16:55:26 -0700
Subject: [PATCH] serial: samsung: protect NULL dereference of clock name
In-Reply-To: <029001cd4e9d$2f2af9b0$8d80ed10$%kim@samsung.com>
References: <001401cd3e3e$644fd3a0$2cef7ae0$%kim@samsung.com>
 <029001cd4e9d$2f2af9b0$8d80ed10$%kim@samsung.com>
Message-ID: <20120620235526.GB31520@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 01:28:47PM +0900, Kukjin Kim wrote:
> Kyoungil Kim wrote:
> > 
> > From: KeyYoung Park <keyyoung.park@samsung.com>
> > 
> > When priting the serial clock source, if clock source name is null,
> > kernel reference NULL point.
> > 
> > Signed-off-by: KeyYoung Park <keyyoung.park@samsung.com>
> > Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
> > Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> 
> (Cc'ed Greg)
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Greg, could you please pick this up?

Already have, thanks.

greg k-h
