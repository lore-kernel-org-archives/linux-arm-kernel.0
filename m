From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 19 Aug 2013 20:11:50 +0100
Subject: [PATCH v4 1/3] ARM: bcm281xx: Add GPIO driver
In-Reply-To: <CAPdLdqn31133KeQgFDcdN8jXDC5qbPn5HOS1mbfOMycMtgDkSg@mail.gmail.com>
References: <1376938761-13657-1-git-send-email-markus.mayer@linaro.org>
 <17431632.gcbUH2MqH0@lenovo>
 <CAPdLdqn31133KeQgFDcdN8jXDC5qbPn5HOS1mbfOMycMtgDkSg@mail.gmail.com>
Message-ID: <2184179.Dja4tiYGvP@lenovo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le lundi 19 ao?t 2013 12:05:55 Markus Mayer a ?crit :
> On 19 August 2013 12:02, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > Hello Markus,
> > 
> > Le lundi 19 ao?t 2013 11:59:19 Markus Mayer a ?crit :
> >> From: Markus Mayer <mmayer@broadcom.com>
> >> 
> >> This patch adds the GPIO driver for the bcm281xx family of chips.
> >> 
> >> Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
> >> Reviewed-by: Christian Daudt <csd@broadcom.com>
> >> Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
> >> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> >> ---
> >> 
> >>  .../devicetree/bindings/gpio/gpio-bcm-kona.txt     |   43 ++
> > 
> > Since the vendor prefix has been changed from brcm to bcm, should that
> > also be reflected in the Device Tree binding documentation file?
> 
> Actually, it is the other way around. "brcm," was there first, but we
> overlooked that and started upstreaming code with the "bcm," vendor
> prefix. There are various patches floating around out there to change
> our use of "bcm," to "brcm," to make it conform to the established
> vendor prefixes.

Ermm yes, I realized that after hitting send. Netherless, should this be 
renamed to "gpio-brcm-kona.txt" directly such that the patches you mention do 
not have to get updated to patch this one too?
-- 
Florian
