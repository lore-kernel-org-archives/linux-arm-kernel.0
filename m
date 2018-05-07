From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 6 May 2018 22:51:55 -0300
Subject: [PATCH] ARM: dts: imx7s: Pass the 'fsl,sec-era' property
In-Reply-To: <20180507011710.GH3443@dragon>
References: <1524601519-23502-1-git-send-email-festevam@gmail.com>
 <20180504071926.GT3443@dragon>
 <CAOMZO5AVjFCad4PC20X5PqMuKGJQ2cOSBnqbGw+ngYCODL2vmQ@mail.gmail.com>
 <20180507011710.GH3443@dragon>
Message-ID: <CAOMZO5CqE_G4_d8VcHT4vjmbpVuNCPMc3EsZ3oDURDuPJLpiFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 6, 2018 at 10:17 PM, Shawn Guo <shawnguo@kernel.org> wrote:

> I applied it for 4.17, but still questioning whether it's reasonable to
> have the property documented as optional in bindings, if missing the
> property results in a non-functional driver.

Thanks Shawn. Yes, after my CAAM patch gets applied it will be a
proper optional property.
