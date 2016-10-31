From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 31 Oct 2016 16:56:34 +0530
Subject: [PATCH v4] ARM: davinci: da8xx: Remove duplicated defines
In-Reply-To: <1477582356-28156-2-git-send-email-abailon@baylibre.com>
References: <1477582356-28156-1-git-send-email-abailon@baylibre.com>
 <1477582356-28156-2-git-send-email-abailon@baylibre.com>
Message-ID: <f2806425-f97a-9ba0-282f-838e96d827ef@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 October 2016 09:02 PM, Alexandre Bailon wrote:
> Some macro for DA8xx CFGCHIP are defined in usb-davinci.h,
> but da8xx-cfgchip.h intend to replace them.
> Remove duplicated defines between da8xx-cfgchip.h and usb-davinci.h
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>

Applied to v4.10/cleanup

For future, for a single patch, no need to add a cover letter.

Thanks,
Sekhar
