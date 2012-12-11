From: amery@geeks.cl (Alejandro Mery)
Date: Tue, 11 Dec 2012 22:58:17 +0100
Subject: [PATCH 0/6] Add pinctrl driver for Allwinner A1X SoCs
In-Reply-To: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <50C7AC79.5010006@geeks.cl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/12 23:08, Maxime Ripard wrote:
> Hi everyone,
>
> This patch set adds a pinctrl driver for the IP found in the Allwinner A10
> and A13, and the SoC-specific bits for the A13. It also adds the documentation
> for the device tree bindings.

Hi. I just wanted to comment that there are 3 known sun5i SoCs, not only 
the A13. The A10s and the A12 are also sun5i. For A10s and A13 there are 
datasheets available with the pin info. So please don't assume the A13's 
pins are "sun5i" pins, they are merely aw1626 (aka A13) pins.

cheers,
Alejandro Mery
