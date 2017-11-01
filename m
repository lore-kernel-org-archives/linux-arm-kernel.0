From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Nov 2017 15:09:56 -0500
Subject: [PATCH v10 2/8] dt-bindings: net: dwmac-sun8i: update
 documentation about integrated PHY
In-Reply-To: <20171031081915.18960-3-clabbe.montjoie@gmail.com>
References: <20171031081915.18960-1-clabbe.montjoie@gmail.com>
 <20171031081915.18960-3-clabbe.montjoie@gmail.com>
Message-ID: <20171101200956.4q7wmfym4lv2vm34@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 09:19:09AM +0100, Corentin Labbe wrote:
> This patch add documentation about the MDIO switch used on sun8i-h3-emac
> for integrated PHY.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/net/dwmac-sun8i.txt        | 147 +++++++++++++++++++--
>  1 file changed, 135 insertions(+), 12 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
