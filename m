From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Nov 2016 13:37:46 +0800
Subject: [PATCH V3 2/2] ARM: dts: add new compatible stream for i.MX6QP
 mmdc
In-Reply-To: <1478539849-10834-2-git-send-email-Frank.Li@nxp.com>
References: <1478539849-10834-1-git-send-email-Frank.Li@nxp.com>
 <1478539849-10834-2-git-send-email-Frank.Li@nxp.com>
Message-ID: <20161114053745.GF3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 11:30:49AM -0600, Frank Li wrote:
> MMDC has a slightly different programming model between imx6q and imx6qp
> in terms of perf support, it's exactly same for suspend support, so we
> have fsl,imx6q-mmdc here to save patching suspend driver with the new
> compatible.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

s/stream/string in subject.

I fixed it up and applied the patch.

Shawn
