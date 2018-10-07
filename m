From: jernej.skrabec@gmail.com (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Sun, 07 Oct 2018 11:50:52 +0200
Subject: [linux-sunxi] [PATCH v2 00/29] Allwinner H6 DE3 and HDMI support
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
Message-ID: <3147828.SFUzx6Pm4T@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne nedelja, 07. oktober 2018 ob 11:38:36 CEST je Jernej Skrabec napisal(a):
> This series adds support for Display Engine 3.0 and HDMI 2.0a, which
> can be found on H6 SoC.
> 
> Display Engine 3.0 in comparison to 2.0 mostly adds features needed for
> displaying and processing 10-bit and AFBC formats, which are not yet
> supported by this series.
> 
> This series is based on linux-next at next-20180828, which has working
> R40 display pipeline support. I'll rebase series on later linux-next, if
> needed, once R40 display pipeline support is reintroduced.

Sorry, I forgot to update above text. It is based on next-20181004 and R40 
HDMI support is already fixed.

Best regards,
Jernej
