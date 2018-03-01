From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 1 Mar 2018 14:55:56 +0530
Subject: [PATCH v3 01/10] dt-bindings: pinctrl: Add bindings for Actions
 S900 SoC
In-Reply-To: <CACRpkdYG_aBJ0WME7NSOdv0pV5Vh_z8GVqQ+tUFnXGA7NGVMUg@mail.gmail.com>
References: <20180228181432.26847-1-manivannan.sadhasivam@linaro.org>
 <20180228181432.26847-2-manivannan.sadhasivam@linaro.org>
 <CACRpkdYG_aBJ0WME7NSOdv0pV5Vh_z8GVqQ+tUFnXGA7NGVMUg@mail.gmail.com>
Message-ID: <20180301092556.x4a5ohx3iccwsugw@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
On Thu, Mar 01, 2018 at 10:20:29AM +0100, Linus Walleij wrote:
> On Wed, Feb 28, 2018 at 7:14 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> 
> > Add pinctrl bindings for Actions Semi S900 SoC
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> The previous (v2) version had Rob's Review tag, did you just forget
> to add it or has something changed?
> 

My bad. Slipped through the cracks.

> If nothing is changed I can add his tag when applying.
>

I will send out a new version of the whole series, incorporating Andy's
pinctrl driver review.

Also, FYI this pacthseries depends on Clock driver patchset I have submitted
earlier. So far no reply from Stephen yet. He said that he is working on setting
up his new environment and will begin reviewing shortly.

Thanks,
Mani 
> Yours,
> Linus Walleij
