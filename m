From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 9 Jan 2018 17:43:48 +0800
Subject: [PATCH V3 1/2] clk: imx: imx7d: add the snvs clock
In-Reply-To: <1515489651-13488-1-git-send-email-Anson.Huang@nxp.com>
References: <1515489651-13488-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180109094348.GG26312@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 05:20:50PM +0800, Anson Huang wrote:
> According to the i.MX7D Reference Manual,
> SNVS block has a clock gate, accessing SNVS block
> would need this clock gate to be enabled, add it
> into clock tree so that SNVS module driver can
> operate this clock gate.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

You missed the last round review tags.

Regards
Dong Aisheng
