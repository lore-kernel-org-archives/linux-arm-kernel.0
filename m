From: sedji.gaouaou@atmel.com (Sedji Gaouaou)
Date: Thu, 25 Feb 2010 17:49:45 +0100
Subject: AC97 audio broken on SAM9263EK?
In-Reply-To: <4B867108.2050806@billgatliff.com>
References: <4B85789D.6000704@billgatliff.com> <4B864C66.6060209@atmel.com>
	<4B867108.2050806@billgatliff.com>
Message-ID: <4B86AA29.8010806@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill,

Here is the patch for the ac97 support on AT91:

http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025629.html

Here is the patch for the full duplex support:

http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025628.html

Best Regards,
Sedji Gaouaou

Le 2/25/2010 1:46 PM, Bill Gatliff a ?crit :
> Sedji Gaouaou wrote:
>> Hi Bill,
>>
>> I have been working on the sam9263 AC97 driver. I have sent a patch to
>> the alsa mailing list but it has not being integrated yet (as far as I
>> know...)(http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025119.html).
>>
>>
>> I have tested it and it worked, but I have recently made some changes
>> so the atmel ac97.c driver could support full duplex mode.
>>
>> So I will submit a new patch by the end of the day/week, and I will
>> copy it to you if you are interested.
>
> Please do!  I'll also take a look at your submitted driver, and see how
> it works for me.
>
>
> Thanks!
>
>
> b.g.
>
