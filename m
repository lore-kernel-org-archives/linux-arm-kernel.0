From: dforsi@gmail.com (Daniele Forsi)
Date: Fri, 4 Jul 2014 14:25:24 +0200
Subject: [PATCH 2/3] ARM: dts: sti: Add st-dwc3 devicetree bindings
 documentation
In-Reply-To: <1404472432-24764-3-git-send-email-peter.griffin@linaro.org>
References: <1404472432-24764-1-git-send-email-peter.griffin@linaro.org>
 <1404472432-24764-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <CAN_we7Mqm0ScULzCSNwmb46MAQNcfckSZ9+iH_3pCfv+VTyUMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-07-04 13:13 GMT+02:00 Peter Griffin:

> +Required properties:
> + - compatible  : must be "st,stih407-dwc3"
> + - reg         : glue logic base address and USB syscfg ctrl register offest
> + - reg-names   : Should be "reg-glue" and "syscfg-reg".
> + - st,syscon    : should be phandle to system configuration node which
> +                 encompases the glue registers.
> + - resets       : phandle pointing to the system powerdown controller

minor knits:
s/offest/offset/
s/encompases/encompasses/
"Should" is upper case while all other lines in this block start with
a lower case letter;
two lines end with a full stop, three lines without;
colons the last lines do not align to the first three

-- 
Daniele Forsi
