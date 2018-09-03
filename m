From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 3 Sep 2018 09:01:59 +0800
Subject: [PATCH][v2] arm64: dts: remove big-endian filed from IFC
 controller
In-Reply-To: <20180829032749.9309-1-prabhakar.kushwaha@nxp.com>
References: <20180829032749.9309-1-prabhakar.kushwaha@nxp.com>
Message-ID: <20180903010157.GX3850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 08:57:49AM +0530, Prabhakar Kushwaha wrote:
> As per IFC binding, Absence of "little-endian" field causes registers
> access in big-endian mode.
> So no need to set explicit big-endian field IFC node for LS1043A and
> LS1046A.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>

s/filed/flied in subject, and having 'fsl' in subject prefix might be
better, so that it's clear this is a fsl specific changes.

I fixed them up and applied the patch.

Shawn
