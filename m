From: peter.griffin@linaro.org (Peter Griffin)
Date: Sat, 5 Jul 2014 07:14:58 +0100
Subject: [PATCH 2/3] ARM: dts: sti: Add st-dwc3 devicetree bindings
 documentation
In-Reply-To: <CAN_we7Mqm0ScULzCSNwmb46MAQNcfckSZ9+iH_3pCfv+VTyUMg@mail.gmail.com>
References: <1404472432-24764-1-git-send-email-peter.griffin@linaro.org>
 <1404472432-24764-3-git-send-email-peter.griffin@linaro.org>
 <CAN_we7Mqm0ScULzCSNwmb46MAQNcfckSZ9+iH_3pCfv+VTyUMg@mail.gmail.com>
Message-ID: <20140705061458.GB8146@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniele,

Thanks for reviewing.

On Fri, 04 Jul 2014, Daniele Forsi wrote:
> 2014-07-04 13:13 GMT+02:00 Peter Griffin:
> 
> > +Required properties:
> > + - compatible  : must be "st,stih407-dwc3"
> > + - reg         : glue logic base address and USB syscfg ctrl register offest
> > + - reg-names   : Should be "reg-glue" and "syscfg-reg".
> > + - st,syscon    : should be phandle to system configuration node which
> > +                 encompases the glue registers.
> > + - resets       : phandle pointing to the system powerdown controller
> 
> minor knits:
> s/offest/offset/
> s/encompases/encompasses/
> "Should" is upper case while all other lines in this block start with
> a lower case letter;
> two lines end with a full stop, three lines without;
> colons the last lines do not align to the first three

All fixed in V2.

Regards,

Peter.
