From: stigge@antcom.de (Roland Stigge)
Date: Thu, 08 Nov 2012 09:21:27 +0100
Subject: [PATCH] pwm: lpc32xx - Add a driver for the motor PWM
In-Reply-To: <20121107203028.GA6186@avionic-0098.mockup.avionic-design.de>
References: <1352305828-25298-1-git-send-email-alban.bedel@avionic-design.de>
 <509A982A.6020401@antcom.de>
 <20121107203028.GA6186@avionic-0098.mockup.avionic-design.de>
Message-ID: <509B6B87.8030102@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/12 21:30, Thierry Reding wrote:
> On Wed, Nov 07, 2012 at 06:19:38PM +0100, Roland Stigge wrote:
>> On 07/11/12 17:30, Alban Bedel wrote:
>>> Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de> --- 
>>> .../devicetree/bindings/pwm/lpc32xx-motor-pwm.txt  |   24 ++ 
>>> arch/arm/boot/dts/lpc32xx.dtsi                     |    7 +
>> 
>> Is all this supposed to go via mach-lpc32xx -> arm-soc.git? Then,
>> I can take this into the lpc32xx tree. Otherwise, you can split
>> off the .dtsi file and I include it via lpc32xx.
> 
> I'd prefer a split between the arch/arm changes and the rest. I'll
> take the drivers/pwm and Documentation changes through the PWM
> tree.

OK, I'll organize everything lpc32xx specific under arch/arm/

Thanks,

Roland
