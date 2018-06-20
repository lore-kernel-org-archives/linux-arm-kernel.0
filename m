From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jun 2018 13:35:36 -0600
Subject: [PATCH v2 1/6] dt-bindings: add laird and giantec vendor prefix
In-Reply-To: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
Message-ID: <20180620193536.GA26356@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2018 at 02:40:50PM +0100, Ben Whitten wrote:
> This adds a vendor prefix "laird" for Laird PLC who make
> CPU modules and system on chips.
> Also adds "giantec" for Giantec Semiconductor, Inc. who
> make eeprom memory used on Laird designs.
> 
> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
