From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Fri, 23 Dec 2011 13:15:28 +0000
Subject: [PATCH v2] davinci: DA850 EVM: OHCI platform code
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6053054@DBDE01.ent.ti.com>
References: <1324452002-8388-1-git-send-email-prakash.pm@ti.com>
 <DF0F476B391FA8409C78302C7BA518B6051CB9@DBDE01.ent.ti.com>
 <4EF1CB8A.10309@mvista.com> <4EF1D011.8060103@mvista.com>
 <DF0F476B391FA8409C78302C7BA518B6053054@DBDE01.ent.ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC027573@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 17:57:16, Nori, Sekhar wrote:
[...]
> > 
> >     Well, I have one idea. We can create a separate module in 
> > arch/arm/mach-davinci/, named say ohci.c, put the shared code there and pass 
> > to it the GPIOs actually used via a function call. Or maybe use existing 
> > arch/arm/mach-davinci/usb.c.
> 
> Thanks Sergei. I think using the existing usb.c would be a better idea.
> 
> Prakash,
> 
> Can you please go ahead with this approach and post updated patches.
> 
> Thanks,
> Sekhar
> 

Ok I will create abstract function and post the new set of patches.

Thanks,
Prakash
