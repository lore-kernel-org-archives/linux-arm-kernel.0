From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Jun 2016 09:29:14 +0800
Subject: [PATCH] ARM: dts: imx: Remove unneeded unit-addresses
In-Reply-To: <1465740943-13876-1-git-send-email-festevam@gmail.com>
References: <1465740943-13876-1-git-send-email-festevam@gmail.com>
Message-ID: <20160616012914.GO20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 11:15:43AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Sparse complains when a unit address is provided without a
> corresponding 'reg' field.
>    
> Fix these build warnings by removing the unneeded unit-addresses of
> the anatop regulators.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Is there any changes from this one [1], which I already applied?

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/497467/
