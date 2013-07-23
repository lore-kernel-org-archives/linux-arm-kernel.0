From: arend@broadcom.com (Arend van Spriel)
Date: Tue, 23 Jul 2013 21:14:49 +0200
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X
 SoC with ARM CPU
In-Reply-To: <CAGVrzcbA72AYu6J3JXBirQQeTiDH9cJThdBdH=Q=gJtOnqz-AA@mail.gmail.com>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716151435.GB3871@linaro.org> <2043662.BcW19XTTMG@lenovo>
 <20130723184907.GA6811@ohporter.com>
 <CAGVrzcbA72AYu6J3JXBirQQeTiDH9cJThdBdH=Q=gJtOnqz-AA@mail.gmail.com>
Message-ID: <51EED629.1000404@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 08:56 PM, Florian Fainelli wrote:
> If you want to add more confusion, because there is,
> drivers/staging/bcm which stands for Beceem has been later acquired by
> Broadcom, eventually turning this 3 letter word into something
> "consistent" from a Broadcom point of view. As far as I am concerned,
> I would just stick with the allocated vendor prefix and replace "bcm"
> with "brcm" because the allocated one is the authoritative one.

Nice, huh. In device-tree notation it identifies the vendor and I agree 
that brcm is a better/preferred vendor id. The confusion here is that 
the device identifiers are all prefixed with "bcm", which is something 
different than the vendor id. I do not think consistency was the goal in 
the acquisition of Beceem ;-)

>> >
>>> >>the bcm281x/kona family support code be merged and use "bcm" there, without
>>> >>registering it. Besides, a simple rule of number here wins:
>>> >>
>>> >>git grep "brcm," * | wc -l
>>> >>63
>>> >>git grep "bcm," * | wc -l
>>> >>25
>>> >>
>>> >>(as of Linux 3.11-rc1)
>>> >>
>>> >>So consistency we should get the bcm281x/kona DT bindings to rename their
>>> >>vendor prefix as well.
>> >
>> >I believe getting this "right" is far more important than the difference
>> >in churn of a mere 38 instances of use of brcm. "Right" is two things:
>> >1) it needs to be consistent 2) it should be what makes sense.
> I agree, which is the reason why I would stick with the vendor prefix
> and end the story there.

Agree.

> --
> Florian

Regards,
Arend
