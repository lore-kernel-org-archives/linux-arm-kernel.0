From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 28 Feb 2017 14:19:22 +0530
Subject: [PATCH v3 6/6] ARM: davinci: add enable GPIOs for vpif capture to
 pdata-quirks
In-Reply-To: <1487772805-19021-7-git-send-email-bgolaszewski@baylibre.com>
References: <1487772805-19021-1-git-send-email-bgolaszewski@baylibre.com>
 <1487772805-19021-7-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <2a617e15-5eab-6a24-9c21-e3ab9ecf3899@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 February 2017 07:43 PM, Bartosz Golaszewski wrote:
> On the da850-evm board we need to select the UI expander video capture
> function to make vpif capture work. Add the relevant GPIOs to the
> pdata-quirks.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hmm, why do we need this despite enable-gpios in DT ?

Thanks,
Sekhar
