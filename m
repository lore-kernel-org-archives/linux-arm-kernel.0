From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Jan 2017 10:28:42 -0600
Subject: [PATCH 2/3] dt-bindings: arm64 ARCH_THUNDER2 platform
 documentation
In-Reply-To: <1484945201-17248-3-git-send-email-jnair@caviumnetworks.com>
References: <1484945201-17248-1-git-send-email-jnair@caviumnetworks.com>
 <1484945201-17248-3-git-send-email-jnair@caviumnetworks.com>
Message-ID: <20170123162842.i5gf3gi4aqb3vffo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 08:46:40PM +0000, Jayachandran C wrote:
> Add documentation for Cavium ThunderX2 CN99XX ARM64 processor family.
> The processor core will use cavium,thunder2 as ID and the SoC will use
> cavium,thunder-99xx
> 
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> ---
>  Documentation/devicetree/bindings/arm/cavium-thunder2.txt | 5 +++++
>  Documentation/devicetree/bindings/arm/cpus.txt            | 1 +
>  2 files changed, 6 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cavium-thunder2.txt

Acked-by: Rob Herring <robh@kernel.org>
