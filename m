From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 3 Sep 2018 09:17:38 +0800
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: select CONFIG_ARM_CPUIDLE
 by default
In-Reply-To: <1535518847-24417-2-git-send-email-Anson.Huang@nxp.com>
References: <1535518847-24417-1-git-send-email-Anson.Huang@nxp.com>
 <1535518847-24417-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180903011737.GA3850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 01:00:47PM +0800, Anson Huang wrote:
> Some i.MX platforms like i.MX7S/D uses generic ARM cpuidle
> driver and psci method to support cpuidle feature, select
> CONFIG_ARM_CPUIDLE by default for such platforms.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
