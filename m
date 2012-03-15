From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Thu, 15 Mar 2012 09:42:20 +0000
Subject: [PATCH] arm:da850: register musb device
In-Reply-To: <4F6081C3.4070905@mvista.com>
References: <1331651015-32586-1-git-send-email-prakash.pm@ti.com>
 <4F5F7F91.8010301@mvista.com>
 <A73F36158E33644199EB82C5EC81C7BC3178406C@DBDE01.ent.ti.com>
 <4F6081C3.4070905@mvista.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC31784B33@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Mar 14, 2012 at 17:02:19, Sergei Shtylyov wrote:
> Hello.
> 
> On 14-03-2012 10:16, Manjunathappa, Prakash wrote:
> 
> >>> Properly set up the OTG mode thru the CFGCHIP2 register, enable the
> >>> USB0_DRVVBUS pin,
> 
> >>      I don't see where you are enabling it.
> 
> > Yes, I will correct the message.
> 
> >>> and finally register the MUSB platform device.
> 
>     Also, you're registering the MUSB device for DA850/OMAP-L138 EVM board, 
> not the whole DA850/OMAP-L138 SoC, so that should be reflected in the subject.
> 

True, I will fix the subject.

Thanks,
Prakash

> >>> Signed-off-by: Ajay Kumar Gupta<ajay.gupta@ti.com>
> >>> Signed-off-by: Manjunathappa, Prakash<prakash.pm@ti.com>
> 
> WBR, Sergei
> 
