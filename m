From: david@lechnology.com (David Lechner)
Date: Sun, 3 Dec 2017 13:56:38 -0600
Subject: [PATCH] ARM: da850: Fix LEGO EV3 battery voltage gpio
In-Reply-To: <1512329373-17321-1-git-send-email-david@lechnology.com>
References: <1512329373-17321-1-git-send-email-david@lechnology.com>
Message-ID: <5c3524e9-a104-001c-b65f-4885337396a7@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/03/2017 01:29 PM, David Lechner wrote:
> This fixes the battery voltage monitoring gpio-hog settings.
> 
> When the gpio is low, it turns off the battery voltage to the ADC chip.
> However, this needs to be on all of the time so that we can monitor
> battery voltage.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Please disregard this patch. Apparently, pinmuxing on platform devices 
is broken in the linux-davinci master branch, which led me astray.
