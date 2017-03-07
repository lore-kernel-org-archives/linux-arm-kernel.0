From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 7 Mar 2017 16:48:16 +0530
Subject: [PATCH v3 3/4] ARM: dts: da850-evm: add the UI expander node
In-Reply-To: <1488298516-14363-4-git-send-email-bgolaszewski@baylibre.com>
References: <1488298516-14363-1-git-send-email-bgolaszewski@baylibre.com>
 <1488298516-14363-4-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <217ae6a9-9ed4-5044-34ef-66848836d0ba@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 February 2017 09:45 PM, Bartosz Golaszewski wrote:
> We need the expander to be probed to allow the VPIF controller to
> receive interrupts from the video decoder.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is basically an IO expander on UI card. So I modified subject line to:

"
ARM: dts: da850-evm: add IO expander node on UI card
"

while applying.

Thanks,
Sekhar
