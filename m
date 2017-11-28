From: greg@kroah.com (Greg KH)
Date: Tue, 28 Nov 2017 09:39:51 +0100
Subject: [PATCH] ARM64: dts: meson-gxl: Add alternate ARM Trusted
 Firmware reserved memory zone
In-Reply-To: <7h8tere1q2.fsf@baylibre.com>
References: <1507735392-20005-1-git-send-email-narmstrong@baylibre.com>
 <7h8tere1q2.fsf@baylibre.com>
Message-ID: <20171128083951.GD9413@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 03:33:25PM -0800, Kevin Hilman wrote:
> Greg,
> 
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
> > This year, Amlogic updated the ARM Trusted Firmware reserved memory mapping
> > for Meson GXL SoCs and products sold since May 2017 uses this alternate
> > reserved memory mapping.
> > But products had been sold using the previous mapping.
> >
> > This issue has been explained in [1] and a dynamic solution is yet to be
> > found to avoid loosing another 3Mbytes of reservable memory.
> >
> > In the meantime, this patch adds this alternate memory zone only for
> > the GXL and GXM SoCs since GXBB based new products stopped earlier.
> >
> > [1] http://lists.infradead.org/pipermail/linux-amlogic/2017-October/004860.html
> >
> > Fixes: bba8e3f42736 ("ARM64: dts: meson-gx: Add firmware reserved memory zones")
> > Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> I missed the Fixes tag on this one, but it's now commit 4ee8e51b9edf upstream.
> 
> Please apply to stable v4.10+

Now applied, thanks.

greg k-h
