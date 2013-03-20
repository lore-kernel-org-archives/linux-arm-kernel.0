From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Wed, 20 Mar 2013 13:47:59 +0100
Subject: [PATCH v2 3/3] ARM: davinci: da850: add EHRPWM & ECAP DT node
In-Reply-To: <51499DB4.9080907@ti.com> (Sekhar Nori's message of "Wed, 20 Mar
 2013 16:59:56 +0530")
References: <1363761714-15034-1-git-send-email-avinashphilip@ti.com>
 <1363761714-15034-4-git-send-email-avinashphilip@ti.com>
 <51499DB4.9080907@ti.com>
Message-ID: <87wqt2qlts.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Sekhar" == Sekhar Nori <nsekhar@ti.com> writes:

 Sekhar> On 3/20/2013 12:11 PM, Philip Avinash wrote:
 >> Add da850 EHRPWM & ECAP DT node.
 >> Also adds OF_DEV_AUXDATA for EHRPWM & ECAP driver to use EHRPWM & ECAP
 >> clock.
 >> 
 >> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
 >> ---
 >> Changes since v1:
 >> - Reusing ti,am33xx<ecap/ehrpwm> as compatible field as both IP's are
 >> same with am33xx platform and da850 has no platform specific
 >> dependency.

 Sekhar> Which is fine, but I think the binding documentation still needs to be
 Sekhar> updated to document the ti,da850-ehrpwm binding. Looping Peter (it is
 Sekhar> always a good idea to CC folks who reviewed your patch last time
 Sekhar> around). Also, please Cc the DT folks and devicetree-discuss list too
 Sekhar> for their opinion.

Yes, thanks for CC'ing me. I also think da850-* should be
documented. See Documentation/devicetree/bindings/gpio/8xxx_gpio.txt for
an similar (old) example.

-- 
Bye, Peter Korsgaard
