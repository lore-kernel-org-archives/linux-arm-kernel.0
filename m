From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 13 Feb 2014 07:11:38 +0100
Subject: [PATCH v4 3/8] at91: dt: Add at91sam9261 dt SoC support
In-Reply-To: <20140212210446.GF11498@piout.net>
References: <1392199607-27452-1-git-send-email-jjhiblot@traphandler.com>
 <1392199607-27452-4-git-send-email-jjhiblot@traphandler.com>
 <20140212210446.GF11498@piout.net>
Message-ID: <CACh+v5O0fJAvT0Ze9RkcVgLQ22Lod+m1ACj0K=GLLA=9r5tVvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-02-12 22:04 GMT+01:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Sorry, one more comment on that patch:
>
> On 12/02/2014 at 11:06:42 +0100, Jean-Jacques Hiblot wrote :
>> +                     pinctrl at fffff400 {
>> +                             #address-cells = <1>;
>> +                             #size-cells = <1>;
>> +                             compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
>> +                             ranges = <0xfffff400 0xfffff400 0xa00>;
>> +
> I believe you got the range wrong, shouldn't it be:
>                                 ranges = <0xfffff400 0xfffff400 0x600>;
>
Yes you're right.
Thanks for the review
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
