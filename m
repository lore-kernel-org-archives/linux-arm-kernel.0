From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Nov 2016 21:30:12 +0100
Subject: [PATCH v2 2/2] pinctrl: single: search for the bits property when
 parsing bits
In-Reply-To: <20161109145401.25327-3-ahaslam@baylibre.com>
References: <20161109145401.25327-1-ahaslam@baylibre.com>
 <20161109145401.25327-3-ahaslam@baylibre.com>
Message-ID: <CACRpkdam=s2Px64iqybciaDMugDaqTT=SgxMKpAMFrQp0PmH7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 3:54 PM, Axel Haslam <ahaslam@baylibre.com> wrote:

> The pcs_parse_bits_in_pinctrl_entry function should search
> for the "pinctrl-single,bits" and not "pinctrl-single,pins"
>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Patch applied with Tony's ACK.

Yours,
Linus Walleij
