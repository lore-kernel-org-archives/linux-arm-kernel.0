From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 27 Nov 2017 10:44:59 +0100
Subject: [PATCH] staging: fsl-mc: fix uninitialized variable use
In-Reply-To: <5A1BDB08.5070808@nxp.com>
References: <20171127090134.19125-1-laurentiu.tudor@nxp.com>
 <20171127090817.GA14195@kroah.com> <5A1BDB08.5070808@nxp.com>
Message-ID: <20171127094459.GA25753@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 09:31:21AM +0000, Laurentiu Tudor wrote:
> 
> 
> On 11/27/2017 11:08 AM, Greg KH wrote:
> > On Mon, Nov 27, 2017 at 11:01:34AM +0200, laurentiu.tudor at nxp.com wrote:
> >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>
> >> Fix this warning triggering on a powerpc build:
> >> warning: 'error' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >>
> >> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >> ---
> >
> > You forgot a reported-by line :(
> >
> > And I beat you by about 30 minutes to this patch, sorry about that.
> 
> Sorry, I guess I'm slow on mondays before having my morning coffee. :-(
> 
> > Next time always test-build your patches...
> 
> I did but it didn't show up on my version of powerpc toolchain (gcc 
> 4.8.1). Maybe it's too old ...

Yes, that's really old, please update to something more "modern" :)

thanks,

greg k-h
