From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 22 May 2017 16:55:15 +0200
Subject: [PATCH 06/13] ARM: dts: armada-385-linksys: usb3 label cleanup
In-Reply-To: <20170521124903.11050-7-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
 <20170521124903.11050-7-ralph.sennhauser@gmail.com>
Message-ID: <20170522145515.GK29447@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 21, 2017 at 02:48:55PM +0200, Ralph Sennhauser wrote:
> Now that we use the reference for the USB3.0 port update the node name
> and labels for the phy and vbus to match the label used by
> armada-38x.dtsi.
> 
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> 
> ---
> 
> Notes:
> 
>   Going by documentation regulator-name is only of informative nature so
>   changing it should be a non issue.

Does the regulator name appear in /sys somewhere?

     Andrew
