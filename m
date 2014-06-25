From: drake@endlessm.com (Daniel Drake)
Date: Wed, 25 Jun 2014 09:56:25 +0100
Subject: [PATCH v2 0/4] Add support for Exynos clock output configuration
In-Reply-To: <1403626107-12073-1-git-send-email-t.figa@samsung.com>
References: <1403626107-12073-1-git-send-email-t.figa@samsung.com>
Message-ID: <CAD8Lp45r4yMq2Ew9Eijs-udLUyteZjriG_86XcQfELvdTbJVNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 24, 2014 at 5:08 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Tested on Odroid U3, with HSIC/USB hub using CLKOUT as reference clock,
> with some additional patches.

for all the patches:
Tested-by: Daniel Drake <drake@endlessm.com>

Tested on ODROID-U2 alongside
    phy: phy-samsung-usb2: Change phy power on/power off sequence

now USB is working fine.

Thanks!
Daniel
