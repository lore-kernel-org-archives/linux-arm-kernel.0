From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 30 Oct 2015 12:31:52 -0700
Subject: [PATCH v5 0/3] NAND support for Broadcom NS2 SoC
In-Reply-To: <1446188361-15146-1-git-send-email-anup.patel@broadcom.com>
References: <1446188361-15146-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <20151030193152.GI13239@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 12:29:18PM +0530, Anup Patel wrote:
> We enable NAND support for Broadcom NS2 SoC by reusing existing
> BRCMNAND driver.
> 
> This patchset applies on-top of "arm64: Simple additions to
> NS2 DT" v1 patchset and is available in ns2_nand_v5 branch of
> https://github.com/Broadcom/arm64-linux.git.
> 
> The patchset is tested on NS2 SVK.

Applied patches 1 and 2. My "Reviewed-by" on patch 3 stands.

Thanks,
Brian
