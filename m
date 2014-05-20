From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 May 2014 17:34:34 -0700
Subject: [PATCH] ARM: DRA752: add detection of SoC information
In-Reply-To: <1400513231-25092-1-git-send-email-nm@ti.com>
References: <1400513231-25092-1-git-send-email-nm@ti.com>
Message-ID: <20140520003433.GB15793@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140519 08:28]:
> Currently the files in /sys/devices/soc0/ show no information about
> DRA7. Few userspace programs do depend on this information to make SoC
> specific support. So update logic to detect the relevant information and
> provide to userspace.

Thanks applying into omap-for-v3.16/soc.

Tony
