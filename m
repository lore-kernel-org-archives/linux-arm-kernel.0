From: david@lechnology.com (David Lechner)
Date: Tue, 17 Jan 2017 12:40:11 -0600
Subject: [PATCH v2 06/14] ARM: davinci: da850: model the SATA refclk
In-Reply-To: <1484655976-25382-7-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-7-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <09c0ec2f-8814-a4b7-ef21-2144e7aad069@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 06:26 AM, Bartosz Golaszewski wrote:
> Register a dummy clock modelling the external SATA oscillator for
> da850 DT mode. For non-DT boot we don't register the clock - instead
> we rely on the default MPY value defined in the da850 ahci driver (as
> is done currently).

Why not register a clock for non-DT boot as well?
