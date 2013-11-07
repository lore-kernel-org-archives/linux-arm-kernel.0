From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 7 Nov 2013 11:57:57 -0800
Subject: [RESEND PATCH 2/4] i2c: i2c-bcm-kona: Add support for high-speed
 mode
In-Reply-To: <20131101130835.GC6734@katana>
References: <1381960909-1735-1-git-send-email-tim.kryger@linaro.org>
 <1381960909-1735-3-git-send-email-tim.kryger@linaro.org>
 <20131101130835.GC6734@katana>
Message-ID: <CAAYSxhrrkSvOJpYPz7txVsot1you3fFzkXJ6fqaS4OgRM0Z2gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 1, 2013 at 6:08 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Wed, Oct 16, 2013 at 03:01:47PM -0700, Tim Kryger wrote:
>> Add support for I2C high-speed mode (3.4 MHz).
>>
>> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
>> Reviewed-by: Matt Porter <matt.porter@linaro.org>
>> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
>
> Mostly good as well:
>
>> +enum hs_bus_speed_index {
>> +     BCM_SPD_3P4MHZ = 0,
>> +};
>
> I just realized that you should update both patches to add the supported
> bus speeds to the binding documentation.

While the bus speed property is really a configuration parameter (and
not a true description of of the hardware) it seems improper to put
driver specific details into the binding document.

Please let me know how you would like me to proceed.

I should mention that I plan to break out the binding into its own
patch as this seems to be the latest best practice just in case that
influences your decision.

Thanks,
Tim Kryger
