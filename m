From: robh@kernel.org (Rob Herring)
Date: Fri, 12 Feb 2016 09:59:02 -0600
Subject: [PATCH 1/3] ARM: mvebu: Define binding for the nsa3xx-hwmon driver
In-Reply-To: <1455147224-6742-2-git-send-email-linux@baker-net.org.uk>
References: <1455147224-6742-1-git-send-email-linux@baker-net.org.uk>
 <1455147224-6742-2-git-send-email-linux@baker-net.org.uk>
Message-ID: <20160212155902.GA13402@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 11:33:42PM +0000, Adam Baker wrote:
> Define a binding for the hardware monitoring chip present in several
> variants of the Zyxel NSA3xx NAS devices.
> 
> Signed-off-by: Adam Baker <linux@baker-net.org.uk>
> ---
>  .../devicetree/bindings/hwmon/nsa320-mcu.txt        | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt

Acked-by: Rob Herring <robh@kernel.org>
