From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 10 Jul 2014 14:25:34 +0100
Subject: [PATCH v6 15/23] regulator: max77686: Setup DVS-related GPIOs on
 probe
In-Reply-To: <CADGdYn4EURaHinWVksQSPzVr=CkZYcrqvWsO7mKDz_gY9XB__Q@mail.gmail.com>
References: <1404467722-26687-1-git-send-email-javier.martinez@collabora.co.uk>
 <1404467722-26687-16-git-send-email-javier.martinez@collabora.co.uk>
 <CADGdYn4EURaHinWVksQSPzVr=CkZYcrqvWsO7mKDz_gY9XB__Q@mail.gmail.com>
Message-ID: <20140710132534.GD11948@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jul 2014, amit daniel kachhap wrote:

> On Fri, Jul 4, 2014 at 3:25 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
> > MAX77686 PMIC support Dyamic Voltage Scaling (DVS) on a set
> > of Buck regulators. A number of GPIO are connected to these
> > lines and are requested by the mfd driver. Setup the GPIO
> > pins from the regulator driver.

> If possible merge this patch with patch 8. Both are adding DVS
> support. Put regmap_copy dependency patch in very beginning.

You want to merge two patches which deal with different subsystems?

That's the opposite of what we usually try and achieve.

> > Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> > ---
> >  drivers/regulator/max77686.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
