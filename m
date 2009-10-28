From: ajay.gupta@ti.com (Gupta, Ajay Kumar)
Date: Wed, 28 Oct 2009 20:48:11 +0530
Subject: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)
In-Reply-To: <4AE85B02.1080207@ru.mvista.com>
References: <200908142241.00528.sshtylyov@ru.mvista.com>
	<4A8A202E.2040505@windriver.com> <4A8A7047.9080405@ru.mvista.com>
	<4A8CF552.3080801@windriver.com>
	<19F8576C6E063C45BE387C64729E73940436EEAE36@dbde02.ent.ti.com>
	<4AE85B02.1080207@ru.mvista.com>
Message-ID: <19F8576C6E063C45BE387C64729E73940436EEAE60@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov at ru.mvista.com]
> Sent: Wednesday, October 28, 2009 8:24 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb at vger.kernel.org; davinci-linux-open-
> source at linux.davincidsp.com; stanley.miao; Hilman, Kevin; david-
> b at pacbell.net; Subbrathnam, Swaminathan; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)
> 
> Hello.
> 
> Gupta, Ajay Kumar wrote:
> 
> > Sergei,
> 
> > Is there any other update to this patch ?
> 
>     The last was take 5 from August 21th:
> 
> http://marc.info/?l=linux-usb&m=125087318308323

Thanks, I will check this one.

> 
>  > We have some patches on top of your base version.
> 
>     Interesting...
> 
> > Kevin and David,
> > There is another TI platform AM3517 which also has same CPPI41 DMA. So
> even this platform has to use same CPPI41 files but there is an issue on
> using cppi4.1 core engine (cppi41.c file at arch/arm/mach-XXX).
> 
>     Are you going to push the AM3517 support upstream?

Currently AM3517 base port patches are being submitted. Once they are done, and cppi4.1 core dependency is cleared then I plan to submit patches on top of your latest version (take 5).

-Ajay
 
> 
> > Can we move this cppi41 core part to some arch/arm/common place so that
> both da8xx and Am3517 can use it ? Or is there any other option ?
> 
>     Adding linux-arm-kernel list to the loop as well...
> 
> > -Ajay
> 
> WBR, Sergei
