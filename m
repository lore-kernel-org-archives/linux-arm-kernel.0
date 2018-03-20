From: sricharan@codeaurora.org (sricharan at codeaurora.org)
Date: Tue, 20 Mar 2018 17:40:52 +0530
Subject: [PATCH v3 13/13] ARM: dts: ipq8074: Enable few peripherals for
 hk01 board
In-Reply-To: <152153134562.254778.8560281830236357589@swboyd.mtv.corp.google.com>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-14-git-send-email-sricharan@codeaurora.org>
 <152153134562.254778.8560281830236357589@swboyd.mtv.corp.google.com>
Message-ID: <cb072bc918d92c8e6e734896fcc2352b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-20 13:05, Stephen Boyd wrote:
> Quoting Sricharan R (2018-03-19 20:58:56)
>> +                        };
>> +               };
>> +
>> +               serial at 78b1000 {
>> +                        pinctrl-0 = <&hsuart_pins>;
>> +                        pinctrl-names = "default";
>> +                        status = "ok";
>> +               };
>> +
>> +               i2c_0 at 78b6000 {
> 
> Node should just be called i2c?
> 
  ok, will fix

Regards,
  Sricharan
