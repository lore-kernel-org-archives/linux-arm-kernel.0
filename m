From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Wed, 18 Nov 2015 16:09:03 +0800
Subject: [PATCH v6 01/19] arm64:ilp32: add documentation on the ILP32
 ABI for ARM64
In-Reply-To: <1447795019-30176-2-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-2-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <564C321F.5050707@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Yury

On 2015/11/18 5:16, Yury Norov wrote:
> From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> 
> Based on Andrew Pinski's original patch-series and adapted with changes
> to reduce the duplication of code-paths and resolve issue found during
> LTP testing.
> 
> Reviewed-by: David Daney <ddaney@caviumnetworks.com>
> 
> 
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
> ---
>  Documentation/arm64/ilp32.txt | 47 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/arm64/ilp32.txt
> 
> diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
> new file mode 100644
> index 0000000..93c09f2
> --- /dev/null
> +++ b/Documentation/arm64/ilp32.txt
> @@ -0,0 +1,47 @@
> +ILP32 AARCH64 SYSCALL ABI
> +=========================
> +Written by Andrew Pinski <apinski@cavium.com>
> +Updated by Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> +Updated by Yury Norov <ynorov@caviumnetworks.com>
> +
> +
> +This document describes the ILP32 syscall ABI and where it differs
> +from the generic linux syscall interface.
> +
> +Some structures are changed to reduce the difference in the code path
> +for both ILP32 and LP64 ABIs for signal handling.
Given that user may upgrade from aarch32 to ILP32. How about add abi
comparison between aarch32 and aarch64 ilp32?

Regards

Bamvor
