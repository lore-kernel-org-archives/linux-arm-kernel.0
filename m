From: kaloz@openwrt.org (Imre Kaloz)
Date: Mon, 6 Mar 2017 11:28:00 +0100
Subject: [PATCH] ARM: DTS armada: Add support for 2 more mvebu model
In-Reply-To: <1488560855-421-1-git-send-email-ansuelsmth@gmail.com>
References: <1488560855-421-1-git-send-email-ansuelsmth@gmail.com>
Message-ID: <1544a3df-6440-4322-e818-3361cd39cd80@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-03-03 18:07, Ansuel Smith wrote:
> This patch add support for 2 Linksys router model
> (shelby and rango). With this we now support all
> the mvebu board on the market.
>
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> Signed-off-by: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   arch/arm/boot/dts/armada-385-linksys-rango.dts  | 443 ++++++++++++++++++++++++
>   arch/arm/boot/dts/armada-385-linksys-shelby.dts | 115 ++++++
>   2 files changed, 558 insertions(+)
>   create mode 100644 arch/arm/boot/dts/armada-385-linksys-rango.dts
>   create mode 100644 arch/arm/boot/dts/armada-385-linksys-shelby.dts
>

NAK. Patch to support shelby has been sent upstream by Ralph - the rango 
dts isn't finalized yet, hence it hasn't been sent upstream.


Best,

Imre
