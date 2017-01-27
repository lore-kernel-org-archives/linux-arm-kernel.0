From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 27 Jan 2017 17:30:48 +0800
Subject: [PATCH v2 02/25] mfd: axp20x: correct name of temperature data
 ADC registers
In-Reply-To: <20170127085458.18270-3-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-3-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v65kt9GdEtZWDRwUF-jVC=gcRYYB-wHgG5wEgx7cfkidEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 4:54 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The registers 0x56 and 0x57 of AXP22X PMIC store the value of the
> internal temperature of the PMIC.
>
> This patch modifies the name of these registers from AXP22X_PMIC_ADC_H/L
> to AXP22X_PMIC_TEMP_H/L so their purpose is clearer.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
