From: B04825@freescale.com (Tabi Timur-B04825)
Date: Mon, 6 Aug 2012 04:08:09 +0000
Subject: [PATCH] ARM: mxs_defconfig: Enable USB host
In-Reply-To: <CAOMZO5BBXwOME2MadkLwf=xJnTQ_djjXbNMkjA9yau1q4x_zgA@mail.gmail.com>
References: <1344186258-30841-1-git-send-email-festevam@gmail.com>
 <20120806025806.GA22302@S2101-09.ap.freescale.net>
 <CAOMZO5CevtbEdch5v9jt5Gyis8o6C1-Vrm1p=289Gpx4zd_wxQ@mail.gmail.com>
 <201208060555.08447.marex@denx.de>
 <CAOMZO5BBXwOME2MadkLwf=xJnTQ_djjXbNMkjA9yau1q4x_zgA@mail.gmail.com>
Message-ID: <CAOZdJXViJCzaD8fHD87xmg3QHfdSmGnn4Oq444uiktjrsuv=8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 5, 2012 at 11:03 PM, Fabio Estevam <festevam@gmail.com> wrote:

> +CONFIG_SCSI=y
> +CONFIG_BLK_DEV_SD=y

I'm not sure about these two.

Try doing this:

make mxs_config
make savedefconfig

And then compare the two defconfigs.  It will tell you which changes to ignore.

-- 
Timur Tabi
Linux kernel developer at Freescale
