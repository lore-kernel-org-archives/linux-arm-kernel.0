From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Nov 2012 15:50:48 +0100
Subject: [PATCH 3/3] ARM: dts: cfa10049: Add PCA9555 GPIO expander to
 the device tree
In-Reply-To: <CACRpkdazguB2BvhMTWz+0JLcH7tC8nc75U6bVMHS2ZYmt6i7=g@mail.gmail.com>
References: <1352394113-19513-1-git-send-email-maxime.ripard@free-electrons.com>
 <1352394113-19513-4-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdazguB2BvhMTWz+0JLcH7tC8nc75U6bVMHS2ZYmt6i7=g@mail.gmail.com>
Message-ID: <50AA4748.7050405@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 17/11/2012 21:12, Linus Walleij a ?crit :
> On Thu, Nov 8, 2012 at 6:01 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
>> Add the GPIO expander found on the i2c1 bus, behind the muxer to the
>> device tree.
>>
>> This gpio expander will be used to get tachymeters values and data ready
>> interruptions from the nuvoton NAU7802 ADCs.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> This does not apply to the GPIO tree, and I have no ACK from the platform
> maintainer so apply it wherever you see fit.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Linus.

Shawn, would you consider applying this patch for 3.8?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
