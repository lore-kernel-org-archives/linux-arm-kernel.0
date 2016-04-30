From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 30 Apr 2016 10:55:04 -0700
Subject: [PATCH v2 2/2] ARM: dts: enable pinctrl for Broadcom NS2 SoC
In-Reply-To: <CACRpkdbsti48b+G8uHfzJvFPzUD8HivE8Fp57CBp_7eGF5wX5Q@mail.gmail.com>
References: <1461934299-14774-1-git-send-email-yendapally.reddy@broadcom.com>
 <1461934299-14774-3-git-send-email-yendapally.reddy@broadcom.com>
 <CACRpkdbsti48b+G8uHfzJvFPzUD8HivE8Fp57CBp_7eGF5wX5Q@mail.gmail.com>
Message-ID: <5724F178.20509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30/04/2016 04:13, Linus Walleij a ?crit :
> On Fri, Apr 29, 2016 at 2:51 PM, Yendapally Reddy Dhananjaya Reddy
> <yendapally.reddy@broadcom.com> wrote:
> 
>> This enables the pinctrl support for Broadcom NS2 SoC
>>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please take this in through the apropriate BCM tree to ARM SoC.

Applied to devicetree-arm64/next, there was a small conflict due to the
crmu node removal while switching to PSCI, Dhanajay, please double check
the result here:

https://github.com/Broadcom/stblinux/commit/8eab685dda30fb15e74d6be07baa9d430a75b8ca
-- 
Florian
