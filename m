From: guohanjun@huawei.com (Hanjun Guo)
Date: Mon, 11 Apr 2016 10:12:42 +0800
Subject: [PATCH v3] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <1459210002-3387-1-git-send-email-al.stone@linaro.org>
References: <1459210002-3387-1-git-send-email-al.stone@linaro.org>
Message-ID: <570B081A.3070403@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/3/29 8:06, Al Stone wrote:
> The ACPI 6.1 specification was recently released at the end of January
> 2016, but the arm64 kernel documentation for the use of ACPI was written
> for the 5.1 version of the spec.  There were significant additions to the
> spec that had not yet been mentioned -- for example, the 6.0 mechanisms
> added to make it easier to define processors and low power idle states,
> as well as the 6.1 addition allowing regular interrupts (not just from
> GPIO) be used to signal ACPI general purpose events.
>
> This patch reflects going back through and examining the specs in detail
> and updating content appropriately.  Whilst there, a few odds and ends of
> typos were caught as well.  This brings the documentation up to date with
> ACPI 6.1 for arm64.
>
> Changes for v3:
>    -- Clarify use of _LPI/_RDI (Vikas Sajjan)
>    -- Whitespace cleanup as pointed out by checkpatch
>
> Changes for v2:
>    -- Clean up white space (Harb Abdulhahmid)
>    -- Clarification on _CCA usage (Harb Abdulhamid)
>    -- IORT moved to required from recommended (Hanjun Guo)
>    -- Clarify IORT description (Hanjun Guo)
>
> Signed-off-by: Al Stone <al.stone@linaro.org>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks for the doc updating!
Hanjun
