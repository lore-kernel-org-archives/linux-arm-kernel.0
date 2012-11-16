From: stigge@antcom.de (Roland Stigge)
Date: Fri, 16 Nov 2012 20:52:52 +0100
Subject: [PATCH 1/2] pwm: lpc32xx - Add a driver for the motor PWM
In-Reply-To: <20121116191606.GA21566@avionic-0098.mockup.avionic-design.de>
References: <1352897985-15419-1-git-send-email-alban.bedel@avionic-design.de>
 <1352897985-15419-2-git-send-email-alban.bedel@avionic-design.de>
 <20121116191606.GA21566@avionic-0098.mockup.avionic-design.de>
Message-ID: <50A69994.1080508@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/11/12 20:16, Thierry Reding wrote:
>> .../devicetree/bindings/pwm/lpc32xx-motor-pwm.txt  |   24 +++ 
>> drivers/pwm/Kconfig                                |   10 + 
>> drivers/pwm/Makefile                               |    1 + 
>> drivers/pwm/pwm-lpc32xx-motor.c                    |  209
>> ++++++++++++++++++++ 4 files changed, 244 insertions(+), 0
>> deletions(-) create mode 100644
>> Documentation/devicetree/bindings/pwm/lpc32xx-motor-pwm.txt 
>> create mode 100644 drivers/pwm/pwm-lpc32xx-motor.c
>> 
>> diff --git
>> a/Documentation/devicetree/bindings/pwm/lpc32xx-motor-pwm.txt
>> b/Documentation/devicetree/bindings/pwm/lpc32xx-motor-pwm.txt new
>> file mode 100644 index 0000000..e19b0a4 --- /dev/null +++
>> b/Documentation/devicetree/bindings/pwm/lpc32xx-motor-pwm.txt @@
>> -0,0 +1,24 @@ +LPC32XX Motor PWM controller + +The LPC32xx motor
>> PWMs have two output pin, A and B, with B=!A.

We have LPC32xx in most places in the kernel, except where upper case
is mandated, like in CONFIG_ options.

Roland
