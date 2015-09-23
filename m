From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 22 Sep 2015 17:31:14 -0700
Subject: [PATCH v10 1/4] clk: clk-vf610: Add clock for Vybrid OCOTP
 controller
In-Reply-To: <ca85ab571ba312ea75a4d33543e5dbb8745e7190.1441609625.git.maitysanchayan@gmail.com>
References: <cover.1441609625.git.maitysanchayan@gmail.com>
 <ca85ab571ba312ea75a4d33543e5dbb8745e7190.1441609625.git.maitysanchayan@gmail.com>
Message-ID: <20150923003114.GB3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 01:51:35PM +0530, Sanchayan Maity wrote:
> Add clock support for Vybrid On-Chip One Time Programmable
> (OCOTP) controller.
> 
> While the OCOTP block does not require explicit clock gating,
> for programming the OCOTP timing register the clock rate of
> ipg clock is required for timing calculations related to fuse
> and shadow register read sequence. We explicitly specify the
> ipg clock for OCOTP as a result.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>

Applied this one, thanks.
