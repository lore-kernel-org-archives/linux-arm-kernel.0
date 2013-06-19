From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 19 Jun 2013 11:45:42 +0300
Subject: [PATCH 3/3] clk: tegra: T114: add DFLL DVCO reset control
In-Reply-To: <20130607121901.21868.65416.stgit@dusk.lan>
References: <20130607121505.21868.72360.stgit@dusk.lan>
 <20130607121901.21868.65416.stgit@dusk.lan>
Message-ID: <20130619084542.GB3847@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 02:19:09PM +0200, Paul Walmsley wrote:
> Add DFLL DVCO reset line control functions to the CAR IP block driver.
> 
> The DVCO present in the DFLL IP block has a separate reset line,
> exposed via the CAR IP block.  This reset line is asserted upon SoC
> reset.  Unless something (such as the DFLL driver) deasserts this
> line, the DVCO will not oscillate, although reads and writes to the
> DFLL IP block will complete.
> 
> Thanks to Aleksandr Frid <afrid@nvidia.com> for identifying this and
> saving hours of debugging time.
> 
> Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Aleksandr Frid <afrid@nvidia.com>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Reviewed-by: <pdeschrijver@nvidia.com>

Cheers,

Peter.
