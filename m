From: jonathan@jonmasters.org (Jon Masters)
Date: Sun, 17 Apr 2016 19:58:03 -0700
Subject: [PATCH v3] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <1459210002-3387-1-git-send-email-al.stone@linaro.org>
References: <1459210002-3387-1-git-send-email-al.stone@linaro.org>
Message-ID: <57144D3B.7020802@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/28/16 5:06 PM, Al Stone wrote:

>   For ACPI on arm64, tables also fall into the following categories:
>
> -       -- Required: DSDT, FADT, GTDT, MADT, MCFG, RSDP, SPCR, XSDT
> +       -- Required: DSDT, FADT, GTDT, IORT, MADT, MCFG, RSDP, SPCR, XSDT

Nit: IORT will only be required on certain SBSA platforms using e.g. 
GICv3-ITS and an SMMU. On e.g. level 0 platforms, it remains optional.

Sorry for late comment - just catching up on this thread.

Jon.
