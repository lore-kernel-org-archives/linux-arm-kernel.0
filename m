From: narkewoody@gmail.com (Woody Wu)
Date: Fri, 16 Nov 2012 01:08:21 +0800
Subject: ttySAC0 or ttyS0 in 3.6.x ARM Linux?
In-Reply-To: <20121115134007.GB25895@glitch>
References: <k824bb$7kp$1@ger.gmane.org>
	<20121115134007.GB25895@glitch>
Message-ID: <CAAsE_udF-ssfSg3wKN-uhn0PgMrR0GSfxViTGk2-sHC_BZEo+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012-11-15 PM9:40?"Domenico Andreoli" <cavokz@gmail.com>???
>
> On Thu, Nov 15, 2012 at 03:07:24PM +0800, woody wrote:
> > Hi,
>
> Hi,
>
> > In the 3.6.6 ARM kernel, should I use ttySAC0 or ttyS0 to specify
> > the 'console' kernel command line?
>
> it depends on the driver used for your console. ttySAC is Samsung. which
> kind of uart do you have?
>
> Regards,
> Domenico

It's a Samsung CPU, s3c2410. How do I check which driver I used in my
kernel config?  I started from s3c2410_defconfig.

I am sure it is ttySAC0 in my 2.6.36 configuration.  Thanks.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/070bd3c2/attachment-0001.html>
