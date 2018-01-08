From: dongas86@gmail.com (Dong Aisheng)
Date: Mon, 8 Jan 2018 18:33:42 +0800
Subject: [PATCH 1/2] clk: imx: imx7d: add the snvs clock
In-Reply-To: <1515078402-22135-1-git-send-email-Anson.Huang@nxp.com>
References: <1515078402-22135-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180108103342.GC32635@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 11:06:41PM +0800, Anson Huang wrote:
> According to the i.MX7D Reference Manual,
> SNVS block has a clock gate, accessing SNVS block
> would need this clock gate to be enabled, add it
> into clock tree so that SNVS module driver can
> operate this clock gate.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
