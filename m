From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 8 Aug 2014 17:19:34 +0200
Subject: [PATCH v2 2/4] arm: mediatek: Add support for GIC interrupt
 polarity extension.
In-Reply-To: <1407508946.4915.10.camel@mtksdaap41>
References: <1407505411-2207-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1407505411-2207-3-git-send-email-srv_yingjoe.chen@mediatek.com>
 <CABuKBeL-dcs+pDW3jUeRWNijyYwx4VUdUB=CjGXoGmQUCifQ5Q@mail.gmail.com>
 <1407508946.4915.10.camel@mtksdaap41>
Message-ID: <CABuKBeKsEHc3wi60FACFz+sUaVZMx9o=j8a+avQq5DsFHJMj+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-08-08 16:42 GMT+02:00 Joe.C <srv_yingjoe.chen@mediatek.com>:
> On Fri, 2014-08-08 at 16:19 +0200, Matthias Brugger wrote:
>> 2014-08-08 15:43 GMT+02:00 Joe.C <srv_yingjoe.chen@mediatek.com>:
>> > From: "Joe.C" <yingjoe.chen@mediatek.com>
>> >
>> > Mediatek SoCs have an interrupt polarity extension which allows
>> > to swap the polarity for given interrupts.
>>
>> Please use ./script/checkpatch.pl, all 4 patches have errors.
>
> Could you send me your result?
> I ran checkpatch.pl again on these patches but didn't see any error.

I get a whole bunch of:
ERROR: DOS line endings

I suppose it's because of the configuration of your mail client.

Best regards,
Matthias

>
> Joe.C
>
>



-- 
motzblog.wordpress.com
