From: oss@buserror.net (Scott Wood)
Date: Fri, 26 Aug 2016 17:42:00 -0500
Subject: [PATCH 09/10] dt-bindings: Update bindings with additional
 vendor for LS1012A
In-Reply-To: <1472207269-18499-9-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <1472207269-18499-9-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <1472251320.13245.14.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-08-26 at 15:57 +0530, Bhaskar Upadhaya wrote:
> Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> ---
> ?Documentation/devicetree/bindings/vendor-prefixes.txt | 2 ++
> ?1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index a7440bc..e9f923d 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -85,6 +85,7 @@ elan	Elan Microelectronic Corp.
> ?embest	Shenzhen Embest Technology Co., Ltd.
> ?emmicro	EM Microelectronic
> ?energymicro	Silicon Laboratories (formerly Energy Micro AS)
> +eon	Eon Silicon Solution, Inc.
> ?epcos	EPCOS AG
> ?epfl	Ecole Polytechnique F?d?rale de Lausanne
> ?epson	Seiko Epson Corp.
> @@ -246,6 +247,7 @@ solomon????????Solomon Systech Limited
> ?sony	Sony Corporation
> ?spansion	Spansion Inc.
> ?sprd	Spreadtrum Communications Inc.
> +sst	Silicon Storage Technology, Inc.
> ?st	STMicroelectronics
> ?startek	Startek
> ?ste	ST-Ericsson

What does LS1012A have to do with these vendors? ?At most your motivation
might be that these chips are on a board that happens to also have an LS1012A
on it, but that doesn't make it an appropriate patch description. ?Better
would be something like "dt-bindings: Add eon and sst vendor strings" with the
changelog body mentioning that you're documenting prefixes that are already in
use.

-Scott
