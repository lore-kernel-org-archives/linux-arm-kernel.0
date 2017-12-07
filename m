From: sebastien.bourdelin@savoirfairelinux.com (Sebastien Bourdelin)
Date: Thu, 7 Dec 2017 12:06:11 -0500
Subject: [PATCH v8 2/2] ARM: dts: TS-4600: add basic device tree
In-Reply-To: <CAOMZO5DcM0u9+DZjywsqadu834++rXAckqnkMqzZOo-vgFVs_w@mail.gmail.com>
References: <20171123210410.7107-1-sebastien.bourdelin@savoirfairelinux.com>
 <20171123210410.7107-2-sebastien.bourdelin@savoirfairelinux.com>
 <CAOMZO5DcM0u9+DZjywsqadu834++rXAckqnkMqzZOo-vgFVs_w@mail.gmail.com>
Message-ID: <1f11151e-fa71-5af6-245d-482fcbcec5e9@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio

On 11/26/2017 02:39 PM, Fabio Estevam wrote:
> Hi Sebastien,
> 
> On Thu, Nov 23, 2017 at 7:04 PM, Sebastien Bourdelin
> <sebastien.bourdelin@savoirfairelinux.com> wrote:
> 
>> +       reg_vddio_sd0: regulator-vddio-sd0 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "vddio-sd0";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               regulator-boot-on;
>> +               gpio = <&gpio3 28 GPIO_ACTIVE_HIGH>;
> 
> It seems this should be GPIO_ACTIVE_LOW instead, as you don't pass
> 'enable-active-high' here.
> 

Yes! you are right, thanks for the catch!

Regards,
Sebastien.
