From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Nov 2015 11:37:37 +0800
Subject: [PATCH] ARM: dts: vfxxx: Fix erroneous property in esdhc0 node
In-Reply-To: <4f43a337677572fbf2b2c8e27152db426e024f7a.1445146992.git.maitysanchayan@gmail.com>
References: <4f43a337677572fbf2b2c8e27152db426e024f7a.1445146992.git.maitysanchayan@gmail.com>
Message-ID: <20151123033735.GD13744@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 18, 2015 at 11:18:48AM +0530, Sanchayan Maity wrote:
> Something seems to have gone wrong during the merging of the device
> tree changes with the following patch
> 
> "ARM: dts: add property for maximum ADC clock frequencies"
> 
> The property "fsl,adck-max-frequency" instead of being applied for
> the ADC1 node got applied to the esdhc0 node. This patch fixes it.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>

Oops, sorry.  Applied it.

Shawn
