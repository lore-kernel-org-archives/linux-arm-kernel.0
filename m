From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 12 Feb 2014 09:53:18 -0200
Subject: [PATCH RFC v2 00/35] Second preview of imx-drm cleanup series
In-Reply-To: <20140210122802.GS26684@n2100.arm.linux.org.uk>
References: <20140210122802.GS26684@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5A=4NS3J365+JQMnyNSfwdiPqTy4gDwNcwV2_ECySTBQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 10:28 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This is the latest revision of my series cleaning up imx-drm and
> hopefully getting it ready to be moved out of drivers/staging.
> This series is updated to v3.14-rc2.
>
> Since the last round of patches were posted, the component support
> has been merged into mainline, and thus dropped from this series.
> Greg has taken the first three patches and merged them into his
> linux-next tree - however, I include them here for completness.
>
> Most of the comments from last time still apply, and I'll look at
> incorporating some of the other patches that were posted in the
> coming week.
>
> If I can have some acks for this, I'll start sending some of it to
> Greg - I'd like to at least get the five or six initial imx-hdmi
> patches to Greg and queued up for the next merge window sooner
> rather than later, preferably getting most of this ready for that
> window too.

Series looks good:

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>

Patch 04/35 will not be needed in the final submission, as there is
already a fix for the build issue in Greg's tree.

Regards,

Fabio Estevam
