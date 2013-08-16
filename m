From: bcousson@baylibre.com (Benoit Cousson)
Date: Fri, 16 Aug 2013 12:40:55 +0200
Subject: [PATCH] ARM:dts: Add devicetree for gta04 board.
In-Reply-To: <1376599385-1697-1-git-send-email-marek@goldelico.com>
References: <1376599385-1697-1-git-send-email-marek@goldelico.com>
Message-ID: <520E01B7.3010804@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 15/08/2013 22:43, Marek Belisko wrote:
> This adds devicetree for gta04 (Openmoko next generation board) with necessary
> support for mmc, usb, leds and button.
>
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>
> This is resurrection of patch sent in March https://lkml.org/lkml/2013/1/24/419
> when I got no reply from maintainer. Patch is updated and based on linux-next (20130807)

Thanks for the update. I added a missing space in the subject and fixed 
an indentation issue for the uart2 node.

Applied in my for_3.12/dts branch.

Regards,
Benoit
