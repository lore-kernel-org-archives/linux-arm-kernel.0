From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Jan 2017 15:09:59 +0530
Subject: [PATCH v2 12/14] ARM: dts: da850: add pinmux settings for the
 SATA controller
In-Reply-To: <1484655976-25382-13-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-13-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <09c88e31-0fd4-15f3-fc0c-25b34b41783b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On Tuesday 17 January 2017 05:56 PM, Bartosz Golaszewski wrote:
> Add pinmux sub-nodes for all muxed SATA pins.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since these are all unused at this time, we should drop adding them
until a time someone really needs these.

Thanks,
Sekhar
