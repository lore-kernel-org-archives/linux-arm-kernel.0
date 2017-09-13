From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 13 Sep 2017 11:05:33 +0530
Subject: da850.dtsi Naming convention Question
In-Reply-To: <CAHCN7xJosHuuPWUkr=ettc8gWgx9m6PvbFe90f2FnvT0meZVUA@mail.gmail.com>
References: <CAHCN7xJ7N6W2Pz1vsVV192V-s0g6q+ozvNBR21rx6LufJ4kR6g@mail.gmail.com>
 <d92f726f-8a84-14ac-571e-f405255fed0b@ti.com>
 <CAHCN7xJosHuuPWUkr=ettc8gWgx9m6PvbFe90f2FnvT0meZVUA@mail.gmail.com>
Message-ID: <27e31de3-ec41-80e1-d1a3-d468df1f5282@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 September 2017 08:58 PM, Adam Ford wrote:
> That makes a lot of sense, but I have a followup question.  Why would
> we only have 1 gpio registered at 22600 when we have multiple banks?
> Again, I am comparing this to the Omap3 because I have more experience
> with that, and they register each bank separately.
> 
> The datasheet breaks it up into small banks, 0-1, 2-3, 4-5, 6-7 and 8
> yet the device tree shows ti,ngpio = <144> and
> ti,davinci-gpio-unbanked = <0>;

Adding Keerthy for this. He maintains the DaVinci GPIO driver and is
much more familiar with it.

> I only ask as I am trying to get more familiar with this platform, and
> I am trying to enhance improve the da850-evm which I realize has been
> replaced by the lcdk.

No problem. Thanks for your work on this platform!

Regards,
Sekhar
