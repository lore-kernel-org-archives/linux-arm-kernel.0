From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 16 Jan 2014 23:35:53 -0500
Subject: linux-next: manual merge of the devicetree tree with the
 arm-soc tree
In-Reply-To: <20140117140853.6faf2c053617c5e66648526f@canb.auug.org.au>
References: <20140117140853.6faf2c053617c5e66648526f@canb.auug.org.au>
Message-ID: <20140117043553.GL29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

On Fri, Jan 17, 2014 at 02:08:53PM +1100, Stephen Rothwell wrote:
> Hi Grant,
> 
> Today's linux-next merge of the devicetree tree got a conflict in
> arch/arm/boot/dts/dove.dtsi between commits 40aad3c1a9b6 ("dt/bindings:
> Remove all references to device_type "ethernet-phy"") and b31b32119abe
> ("ARM: dove: sort DT nodes by address") from the devicetree tree and
> commit 351291754df3 ("dt/bindings: remove device_type "network"
> references") from the devicetree tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Looks good, thanks.

Jason.
