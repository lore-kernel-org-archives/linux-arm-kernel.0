From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 22:19:22 +0100
Subject: [PATCH v2 1/3] devicetree: bindings: Document qcom,
 msm-id and qcom, board-id
In-Reply-To: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
Message-ID: <2483237.3YTlNsnOp7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 March 2015 15:13:20 Kumar Gala wrote:
> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
> on Qualcomm MSM platforms to determine which device tree should be
> utilized and passed to the kernel.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

This seems to duplicate the root-node compatible strings for no particular
reason, with a less flexible format. I think it would be better to fix
the boot loader.

	Arnd
