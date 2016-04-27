From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Apr 2016 00:31:19 -0300
Subject: [PATCH 2/2] ARM: dts: imx6ul-pico-hobbit: Add initial support
In-Reply-To: <20160426014938.GC8870@tiger>
References: <1460985138-6271-1-git-send-email-fabio.estevam@nxp.com>
 <1460985138-6271-2-git-send-email-fabio.estevam@nxp.com>
 <20160426014938.GC8870@tiger>
Message-ID: <CAOMZO5Cek=zwU4xN9jO06XoJ5_3NNXYOPzhe4YVdYuheVZFbJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 10:49 PM, Shawn Guo <shawnguo@kernel.org> wrote:

>> +     backlight {
>> +             compatible = "pwm-backlight";
>> +             pwms = <&pwm3 0 5000000>;
>> +             brightness-levels = <0 4 8 16 32 64 128 255>;
>> +             default-brightness-level = <6>;
>> +             status = "okay";
>> +     };
>> +
>> +     reg_sd1_vmmc: reg-sd1-vmmc {
>
> regulator-xxx for node name please.

Sorry, Shawn. I missed this email.

Will prepare v4.
