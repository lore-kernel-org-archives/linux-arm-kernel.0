From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Dec 2016 23:45:21 +0800
Subject: [PATCH v2 03/11] power: supply: axp20x_usb_power: set min voltage
 and max current from sysfs
In-Reply-To: <20161209110419.28981-4-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
 <20161209110419.28981-4-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v65nevjF1ALCyHkXE5ggzsb9gj82w3W9ubPeOeA2PAKZgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2016 at 7:04 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> AXP20X and AXP22X PMICs allow setting the min voltage and max current of
> VBUS power supply. This adds entries in sysfs to allow to do so.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
