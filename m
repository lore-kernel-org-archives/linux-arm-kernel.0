From: bp@alien8.de (Borislav Petkov)
Date: Sat, 23 Jan 2016 15:34:15 +0100
Subject: [PATCH v3 0/3] edac: xgene: Add missing SoC register bus error
 handling and fix CE promotes to UE
In-Reply-To: <1453495625-28006-1-git-send-email-lho@apm.com>
References: <1453495625-28006-1-git-send-email-lho@apm.com>
Message-ID: <20160123143415.GD16329@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 01:47:02PM -0700, Loc Ho wrote:
> Add missing register bus error handling for SoC and fix an checking
> condition for CE error promotes to UE. DT binding and documentation are
> also updated.
> 
> v3:
> * Move the regmap-rb property back to the required section.
> * Fix typo in documentation and comment code
> 
> v2:
> * Make the register bus resource optional
> * Update DT binding accordinlgy
> 
> ---
> Loc Ho (3):
>   Documentation: Update the APM X-Gene SoC EDAC DTS binding for missing
>     RB
>   edac: xgene: Add missing SoC register bus error handling and fix CE
>     promotes to UE
>   arm64: Update the APM X-Gene EDAC node with the RB register resource
> 
>  .../devicetree/bindings/edac/apm-xgene-edac.txt    |   10 +++
>  arch/arm64/boot/dts/apm/apm-storm.dtsi             |    6 ++
>  drivers/edac/xgene_edac.c                          |   70 +++++++++++++++++++-
>  3 files changed, 85 insertions(+), 1 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
