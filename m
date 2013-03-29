From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Fri, 29 Mar 2013 07:24:04 +0000 (GMT)
Subject: [PATCH] arm: mvebu: Add GPIO LEDs to Mirabox board
In-Reply-To: <1364523024-20306-1-git-send-email-ryan@presslab.us>
References: <1364523024-20306-1-git-send-email-ryan@presslab.us>
Message-ID: <alpine.DEB.2.02.1303290719570.31379@vroombuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 28 Mar 2013, Ryan Press wrote:

> Add the three external LED definitions to the device tree file on
> the Mirabox.
>
> The Mirabox user guide calls out one as a power LED, and the other
> two are defined for WiFi, but as the current mwifiex drivers don't
> have LED support, we make them status LEDs.
>
> These have been tested working by writing to the appropriate
> /sys/class/leds trigger.
>
> Signed-off-by: Ryan Press <ryan@presslab.us>
> ---
> arch/arm/boot/dts/armada-370-mirabox.dts | 37 ++++++++++++++++++++++++++++++++
> 1 file changed, 37 insertions(+)

Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>

Cheers,
Neil
