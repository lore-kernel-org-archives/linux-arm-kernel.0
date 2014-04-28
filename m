From: tim.kryger@linaro.org (Tim Kryger)
Date: Mon, 28 Apr 2014 08:00:39 -0700
Subject: [PATCH v6 RESEND 0/5] Add Broadcom Kona PWM Support
In-Reply-To: <20140428110731.GH19455@ulmo>
References: <1398450675-19609-1-git-send-email-tim.kryger@linaro.org>
 <20140428110731.GH19455@ulmo>
Message-ID: <CAAYSxhpOP78EQAM0cWM2RwLu29-0eRVgLCFX3Hob8q=J==5wUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 4:07 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Fri, Apr 25, 2014 at 11:31:10AM -0700, Tim Kryger wrote:
>> This series introduces the driver for the Kona PWM controller found in
>> Broadcom mobile SoCs like bcm281xx and updates the device tree and the
>> defconfig to enable use of this hardware on the bcm28155 AP board.
>>

>> Tim Kryger (5):
>>   Documentation: dt: Add Kona PWM binding
>>   pwm: kona: Introduce Kona PWM controller support
>>   ARM: dts: Declare the PWM for bcm11351 (bcm281xx)
>>   ARM: dts: Enable the PWM for bcm28155 AP board
>>   ARM: bcm_defconfig: Enable PWM and Backlight

> I've applied patches 1 and 2 (with two tiny whitespace cleanups) to my
> for-next branch.

Sounds good.  Thank you.

Matt and Christian, are you okay taking patches 3-5 through your tree?

-Tim
