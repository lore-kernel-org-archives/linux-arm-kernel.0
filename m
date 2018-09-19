From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 19 Sep 2018 15:08:03 +0200
Subject: [PATCH v3 0/9] add support for relative references in jump tables
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
Message-ID: <20180919130803.GH24124@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 11:51:35PM -0700, Ard Biesheuvel wrote:

> Ard Biesheuvel (8):
>   kernel/jump_label: abstract jump_entry member accessors
>   kernel/jump_label: implement generic support for relative references
>   arm64/kernel: jump_label: switch to relative references
>   x86: add support for 64-bit place relative relocations
>   x86: jump_label: switch to jump_entry accessors
>   x86/kernel: jump_table: use relative references
>   jump_label: annotate entries that operate on __init code earlier
>   jump_table: move entries into ro_after_init region
> 
> Heiko Carstens (1):
>   s390/jump_label: switch to relative references

This all looks good to me;

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Ingo, could you queue this?
