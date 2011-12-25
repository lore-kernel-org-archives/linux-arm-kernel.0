From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sat, 24 Dec 2011 18:03:24 -0600
Subject: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
In-Reply-To: <CAMP44s2JWRN4XVCVrbVUJwZK9zkT6p2dPnK2SPuZXJPj71c4Yg@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
 <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
 <CAMP44s3Jb9DZLUyDVU_HmQbaJKp=2qym7Z6uauNchJh0fPL4hQ@mail.gmail.com>
 <CAB-zwWhpmwRP2mNu-CdX-RVgmTRjw0UsYckAVsM+qztmVdvc7A@mail.gmail.com>
 <CAMP44s0hYWiZ8OnjQ6Jy_W7MCveP+WyHG18Tt2jRGzxSwoQP3w@mail.gmail.com>
 <CAB-zwWio5iMTyofv3Hx5Q7G7rYY5cRU4kXNQzMF0NRprEd8=5g@mail.gmail.com>
 <CAMP44s2JWRN4XVCVrbVUJwZK9zkT6p2dPnK2SPuZXJPj71c4Yg@mail.gmail.com>
Message-ID: <CAB-zwWicBq8sUZCiRLP_6QX3jL7gsTvF0-NP1r+AvDWP+aWsMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2011 at 11:04 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Which omap-iommu? The platform driver, or the device stuff? The device
> stuff is always built-in, but not the platform driver
> (drivers/iommu/omap-iommu.c), that can be a module.

Both, I can't recall exactly when it changed (prior to being moved to
drivers/iommu it could be built as a module), but now
CONFIG_OMAP_IOMMU is boolean type.

Regards,

Omar
