From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 3 Sep 2018 07:58:14 +0800
Subject: [PATCH 1/2][RESEND] ARM: dts: Add big-endian in nor node for
 ls1021a
In-Reply-To: <20180828065936.8040-2-prabhakar.kushwaha@nxp.com>
References: <20180828065936.8040-1-prabhakar.kushwaha@nxp.com>
 <20180828065936.8040-2-prabhakar.kushwaha@nxp.com>
Message-ID: <20180902235812.GS3850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 12:29:35PM +0530, Prabhakar Kushwaha wrote:
> NOR and IFC controller connectivity is big-endian.
> So add big-endian field in nor device tree node allowing
> IFC controller to read/write data from/to the flash correctly.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>

Applied both, thanks.
