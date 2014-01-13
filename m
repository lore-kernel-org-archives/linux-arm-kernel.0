From: robdclark@gmail.com (Rob Clark)
Date: Mon, 13 Jan 2014 13:56:27 -0500
Subject: [BUILD BUG] msm: mdp4_drv_encoder.c
In-Reply-To: <20140113184324.GE15937@n2100.arm.linux.org.uk>
References: <20140113184324.GE15937@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGssWPvFkKrqZwsN+WPr=Hkgs-DXZYO7Ywdu5MSeknHGaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 1:43 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Referencing mach/*.h from drivers does not work in multi-platform
> kernels, and leads to errors such as this:
>
> drivers/gpu/drm/msm/mdp4/mdp4_dtv_encoder.c:18:22: fatal error: mach/clk.h: No such file or directory
>
> which were found via my allmodconfig build.

dropping this #include is already in my 3.14-rc1 pull req..

do we need this in 3.13 too?

BR,
-R

>
> --
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
