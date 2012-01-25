From: dhlii@dlasys.net (David Lynch Jr.)
Date: Wed, 25 Jan 2012 13:56:22 -0500
Subject: [Fwd: Re: imx53]
Message-ID: <1327517782.21058.49.camel@hp-dhlii>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I just pulled the most recent copy of linus's tree 3.3 something. 
It appears that significantly more i.mx53 drivers are getting into that
source than last time I looked. 

Now I am trying to build it for the i.MX53 QSB - the development
platform I am using. 

Myriads of config options have changed since the 2.6.38.3 that I have
somewhat working. Just borrowing the .config appears to be
insufficient. 

After some mucking arround that included Kconfig changes I was able to
get CONFIG_FB_IMX set and build a kernel with it, but it does not appear
to be getting initialized. 

What do I need to do to get Linux to use this driver ?
Has ARM 3.3 moved to device trees ?

Is there something else I am missing ?


 



-------- Forwarded Message --------
> From: Fabio Estevam <festevam@gmail.com>
> To: David H. Lynch Jr. <dhlii@dlasys.net>
> Cc: linux-arm-kernel at lists.infradead.org
> <linux-arm-kernel@lists.infradead.org>
> Subject: Re: imx53
> Date: Wed, 18 Jan 2012 17:57:48 -0200
> 
> On Wed, Jan 18, 2012 at 1:39 PM, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
> > Where would I look for the appropriate git kernel source tree that is being
> > used for i.MX53 development feeding the distribution kernel ?
> 
> You can use Linus' tree directly.
> 
> Regards,
> 
> Fabio Estevam
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
