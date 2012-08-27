From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 27 Aug 2012 10:25:10 -0700
Subject: [PATCH] dma: imx-dma: Fix kernel crash due to missing clock
 conversion
In-Reply-To: <CAOMZO5A3v-K3OGghy2wYqkyqba5y=NcGSXa4C=9bEFHn1x6vaQ@mail.gmail.com>
References: <1341341045-9472-1-git-send-email-fabio.estevam@freescale.com>
 <20120827163006.0cffd20c@eb-e6520>
 <20120827165242.GA11102@kroah.com>
 <CAOMZO5A3v-K3OGghy2wYqkyqba5y=NcGSXa4C=9bEFHn1x6vaQ@mail.gmail.com>
Message-ID: <20120827172510.GA25335@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 02:12:10PM -0300, Fabio Estevam wrote:
> On Mon, Aug 27, 2012 at 1:52 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> 
> > Ok, should I just revert it?  It's still needed on 3.5, right?
> 
> Yes, please revert it from 3.4 and keep it on 3.5.

Thanks for letting me know, now reverted.

greg k-h
