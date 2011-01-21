From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Jan 2011 11:27:36 -0000
Subject: [PATCH v2 3/3] ARM: oprofile: Always allow backtraces
In-Reply-To: <1295549840-17809-4-git-send-email-kauppi@papupata.org>
References: <1295549840-17809-1-git-send-email-kauppi@papupata.org>
	<1295549840-17809-4-git-send-email-kauppi@papupata.org>
Message-ID: <001601cbb95e$3479e820$9d6db860$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ari,

> Always allow backtrace when using oprofile on ARM, even if a PMU
> isn't present. Implemented by removing code and using stubs
> provided by <linux/oprofile.h>.
> 
> Restores functionality originally introduced in commit
> 1b7b56982fdcd9d85effd76f3928cf5d6eb26155 ("oprofile: Always allow
> backtraces on ARM") by Richard Purdie.
> 
> Signed-off-by: Ari Kauppi <kauppi@papupata.org>
> ---
>  arch/arm/oprofile/common.c |   12 ++----------
>  1 files changed, 2 insertions(+), 10 deletions(-)

[...]

Providing Robert is happy with the associated changes to
linux/oprofile.h then this patch looks good to me.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
