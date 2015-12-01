From: sbranden@broadcom.com (Scott Branden)
Date: Tue, 1 Dec 2015 08:05:41 -0800
Subject: [PATCH 3/3] ARM: dts: enable pinctrl for Broadcom NSP
In-Reply-To: <CACRpkdZCBbrfHq+DiWcfe6i_2FPUXyMQwbsQu5_zAKYa=fJugg@mail.gmail.com>
References: <1448042309-46445-1-git-send-email-yrdreddy@broadcom.com>
 <5654FBE4.5010802@gmail.com>
 <CACRpkdZCBbrfHq+DiWcfe6i_2FPUXyMQwbsQu5_zAKYa=fJugg@mail.gmail.com>
Message-ID: <565DC555.2070004@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 15-12-01 02:00 AM, Linus Walleij wrote:
> On Wed, Nov 25, 2015 at 1:08 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 20/11/15 09:58, Yendapally Reddy Dhananjaya Reddy wrote:
>>> This enables the pinctrl support for Broadcom NSP SoC
>>>
>>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yrdreddy@broadcom.com>
>>
>> Looks like a sane pinctrl node here, unless there are objections, I
>> would like to go ahead and apply this for v4.5, thanks!
>
> I'm waiting for an indication from the other BCM pinctrl
> maintainers to tell whether this SoC is unique enough to deserve
> its own driver.
If Stephen Warren is the other maintainer you are talking about he does 
not work at Broadcom.  I don't think he is familiar with the variety of 
pinctrl implementations present.  But yes, the pinctrl implementations 
have been rather unique in these Socs.  As Ray indicated we're trying to 
get the silicon designers to standardize more going forward so we don't 
have to create unique drivers for these SoCs.
>
> Yours,
> Linus Walleij
>

Regards,
  Scott
