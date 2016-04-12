From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 12 Apr 2016 13:55:41 +0800
Subject: [PATCH 1/3] ARM: dts: vf-colibri: alias the primary FEC as
 ethernet0
In-Reply-To: <1459577621-3160-1-git-send-email-stefan@agner.ch>
References: <1459577621-3160-1-git-send-email-stefan@agner.ch>
Message-ID: <20160412055541.GB23166@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 11:13:39PM -0700, Stefan Agner wrote:
> The Vybrid based Colibri modules provide a on-module PHY which is
> connected to the second FEC instance FEC1. Since the on-module
> Ethernet port is considered as primary ethernet interface, alias
> fec1 as ethernet0. This also makes sure that the first MAC address
> provided by the boot loader gets assigned to the FEC instance used
> for the on-module PHY.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied all, thanks.
