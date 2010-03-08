From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 8 Mar 2010 20:46:28 +0100
Subject: [PATCH 1/2 v3] ARM: SAMSUNG: Move HWMON from plat-s3c24xx to
	plat-samsung
In-Reply-To: <b2e8f9f71001261615tf492c27o12a3c358defbe39f@mail.gmail.com>
References: <b2e8f9f71001260316l56cdfc7bv20944b4e3ba3fdf5@mail.gmail.com>
	<20100126145008.GB9153@trinity.fluff.org>
	<b2e8f9f71001261615tf492c27o12a3c358defbe39f@mail.gmail.com>
Message-ID: <b2e8f9f71003081146rf15d89fx2421561dbe82ff6d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 01:15, Maurus Cuelenaere <mcuelenaere@gmail.com> wrote:
> Move HWMON platform definition from plat-s3c24xx to plat-samsung
> and adjust mach-bast to use the new s3c_hwmon_set_platdata().
>
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
> Changes since v2:
> remove EXPORT_SYMBOL
> add kerneldoc for s3c_hwmon_set_platdata
> attribute original copyright holder
>
> Changes since v1:
> select S3C_DEV_HWMON for mach-bast config
>

Any updates on this?

--
Maurus Cuelenaere
