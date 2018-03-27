From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 27 Mar 2018 16:01:47 +0800
Subject: [PATCH v2 1/2] Revert "arm64: dts: fsl: fix ifc simple-bus unit
 address format warnings"
In-Reply-To: <1522081243-30871-1-git-send-email-festevam@gmail.com>
References: <1522081243-30871-1-git-send-email-festevam@gmail.com>
Message-ID: <20180327080145.GF8857@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2018 at 01:20:42PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> This reverts commit f81d7af7957539b7808961f929f945381530acb9.
> 
> As explained by Rob Herring:
> 
> "This "fix" is wrong. Memory controllers with chip selects should have
> the chip select in the unit-address. The correct fix here is you should
> drop "simple-bus"."
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied both, thanks.
