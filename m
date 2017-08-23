From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 22 Aug 2017 22:38:47 -0700
Subject: [PATCH] staging: fsl-mc: be consistent when checking strcmp()
 returns
In-Reply-To: <1503455625.6933.12.camel@perches.com>
References: <20170817115504.4308-1-laurentiu.tudor@nxp.com>
 <20170823014031.GA14400@kroah.com>
 <1503455625.6933.12.camel@perches.com>
Message-ID: <20170823053847.GF23426@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 07:33:45PM -0700, Joe Perches wrote:
> On Tue, 2017-08-22 at 18:40 -0700, Greg KH wrote:
> > On Thu, Aug 17, 2017 at 02:55:04PM +0300, laurentiu.tudor at nxp.com wrote:
> > > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > 
> > > Throughout the driver we use == 0 / != 0 to check strcmp() returns except
> > > this place, so fix it.
> > 
> > You will just get someone else fixing it as it is not what checkpatch
> > recommends, so just leave it as-is please.
> 
> No.  That's not correct.
> 
> checkpatch does not make a recommendation about
> style use with the strcmp family of functions.

Ah, ok, nevermind then...

Laurentiu, can you resend this?

thanks,

greg k-h
