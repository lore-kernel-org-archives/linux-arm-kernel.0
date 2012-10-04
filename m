From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 4 Oct 2012 11:07:28 -0300
Subject: [PATCH] ARM : i.MX27 : split code for allocation of ressources of
 camera and eMMA
In-Reply-To: <CAOMZO5CAvwwGEwbZE2VS49tpWOYxAR_qQkfKhswPaofSrni92A@mail.gmail.com>
References: <1346763398-13536-1-git-send-email-gcembed@gmail.com>
 <CACKLOr0PO1jbxrfRoEwEAGFNkNkAFUA-oB2vLZpw1kDxEYPBQw@mail.gmail.com>
 <5047013E.30508@gmail.com>
 <CACKLOr1RipM3QVJBaTjXHFotqSMdrCsWLkBsgiiuauTWpxR6EQ@mail.gmail.com>
 <50471187.3040809@gmail.com>
 <CACKLOr0=TccMNoQV-LfkeBrCN5=0E8eqTEaT7PRk-KAv_mQ5RQ@mail.gmail.com>
 <50471CEE.60606@gmail.com>
 <CAOMZO5D7DrUwg1YYwPnXgMj4nsgS=2ctnb7J3n-60hkreoP3yw@mail.gmail.com>
 <504769CF.2070904@gmail.com>
 <CAOMZO5DyjdrZYNDMuT1=yuxQcHuP3=6dy_j_ja1vub56_m3pvA@mail.gmail.com>
 <504774B7.8090007@gmail.com>
 <CAOMZO5CAvwwGEwbZE2VS49tpWOYxAR_qQkfKhswPaofSrni92A@mail.gmail.com>
Message-ID: <CAOMZO5C+NNQr0mo6P2cKx4RxFoQPyYuPZq4eFUZnvi_7gTRkBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Wed, Sep 5, 2012 at 3:20 PM, Fabio Estevam <festevam@gmail.com> wrote:

> Sylwester suggested me this patch and it fixed the issue:
> http://git.linuxtv.org/snawrocki/media.git/commitdiff/458b9b5ab8cb970887c9d1f1fddf88399b2d9ef2
>
> Now ov2640 probes correctly on mx31pdk, but on mx27pdk I have:
>
> soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
> mx2-camera mx2-camera.0: Camera driver attached to camera 0
> ov2640 0-0030: Product ID error fb:fb
> mx2-camera mx2-camera.0: Camera driver detached from camera 0
> mx2-camera mx2-camera.0: MX2 Camera (CSI) driver probed, clock
> frequency: 66500000
>
> This works fine in 3.4.10 and I suspect this problem is due to the imx
> clock conversion as the csi clock frequency looks incorrect.
>
> Javier,
>
> Can you get your camera working on visstrim board using linux-next or
> 3.6-rc4? Any patches I am missing?

Could you please confirm if your camera works with the latest kernel?

If so, could you please your log below?

Not sure if the clock frequency below is correct.

> soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
> mx2-camera mx2-camera.0: Camera driver attached to camera 0
> ov2640 0-0030: Product ID error fb:fb
> mx2-camera mx2-camera.0: Camera driver detached from camera 0
> mx2-camera mx2-camera.0: MX2 Camera (CSI) driver probed, clock
> frequency: 66500000

Thanks,

Fabio Estevam
