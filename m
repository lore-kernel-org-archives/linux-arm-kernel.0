From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Oct 2012 10:55:42 +0200
Subject: [PATCH 1/2] i2c: mux: Add dt support to i2c-mux-gpio driver
In-Reply-To: <50808481.6040501@wwwdotorg.org>
References: <1350569623-4699-1-git-send-email-maxime.ripard@free-electrons.com>
 <1350569623-4699-2-git-send-email-maxime.ripard@free-electrons.com>
 <50808481.6040501@wwwdotorg.org>
Message-ID: <5081158E.4040308@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/10/2012 00:36, Stephen Warren a ?crit :
> On 10/18/2012 08:13 AM, Maxime Ripard wrote:
>> Allow the i2c-mux-gpio to be used by a device tree enabled device. The
>> bindings are inspired by the one found in the i2c-mux-pinctrl driver.
> 
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
> 
>> +Optional properties:
>> +- idle-state: value to set to the muxer when idle. When no value is
>> +  given, it defaults to the first value in the array.
> 
> That's inconsistent with the following text that appears later (and
> describes what the driver actually does):

Ah, right, sorry

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
