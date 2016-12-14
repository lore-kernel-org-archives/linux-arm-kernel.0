From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Dec 2016 23:38:06 +0800
Subject: [PATCH v2 01/11] power: supply: axp20x_usb_power: use
 of_device_id data field instead of device_is_compatible
In-Reply-To: <20161209110419.28981-2-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
 <20161209110419.28981-2-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v67GHZ6fq6PoSJt3O3170ej1Gjkc5PGgCRptSQjcOi=zXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2016 at 7:04 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> This replaces calls to of_device_is_compatible to check data field of
> of_device_id matched when probing the driver.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
