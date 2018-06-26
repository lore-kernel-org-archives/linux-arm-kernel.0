From: jmorris@namei.org (James Morris)
Date: Wed, 27 Jun 2018 05:13:31 +1000 (AEST)
Subject: [PATCH v9 4/6] init: allow initcall tables to be emitted using
 relative references
In-Reply-To: <20180626182802.19932-5-ard.biesheuvel@linaro.org>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
 <20180626182802.19932-5-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LRH.2.21.1806270513020.18107@namei.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jun 2018, Ard Biesheuvel wrote:

> Allow the initcall tables to be emitted using relative references that
> are only half the size on 64-bit architectures and don't require fixups
> at runtime on relocatable kernels.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  include/linux/init.h   | 44 +++++++++++++++-----
>  init/main.c            | 32 +++++++-------
>  kernel/printk/printk.c | 16 +++----
>  security/security.c    | 17 ++++----
>  4 files changed, 68 insertions(+), 41 deletions(-)


Acked-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
