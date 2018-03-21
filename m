From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Mar 2018 10:43:11 +0800
Subject: [PATCH 2/2] dt-bindings: regulator: add QCOM RPMh regulator
 bindings
In-Reply-To: <b718873e5ad53a2e8df6a5103828a4c04881d564.1521246069.git.collinsd@codeaurora.org>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <b718873e5ad53a2e8df6a5103828a4c04881d564.1521246069.git.collinsd@codeaurora.org>
Message-ID: <20180321024311.GW2186@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 06:09:11PM -0700, David Collins wrote:
> Introduce bindings for RPMh regulator devices found on some
> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

> +=========================================
> +Second Level Nodes - Regulators
> +=========================================
> +
> +- regulator-name

This document appears to be reproducing the standard regulator bindings;
there is no need to do that, just reference them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180321/8014c15f/attachment-0001.sig>
