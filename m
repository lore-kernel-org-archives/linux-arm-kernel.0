From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 17:51:30 +0100
Subject: [PATCH 18/25] arm64: ilp32: introduce binfmt_ilp32.c
In-Reply-To: <1459894127-17698-19-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-19-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160422165130.GQ2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 01:08:40AM +0300, Yury Norov wrote:
> --- /dev/null
> +++ b/arch/arm64/kernel/binfmt_ilp32.c

[...]

> +#include "../../../fs/binfmt_elf.c"

How different is this new binfmt_ilp32.c file from the first part of
compat_binfmt_elf.c? I wonder whether we could include the latter here
instead and make this similar to binfmt_elf32.c introduced by the
previous patch.

-- 
Catalin
