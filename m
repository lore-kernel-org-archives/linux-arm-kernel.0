From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Feb 2014 14:53:47 +0000
Subject: [PATCH v2 1/1] audit: Add CONFIG_HAVE_ARCH_AUDITSYSCALL
In-Reply-To: <1393319784-2758-2-git-send-email-takahiro.akashi@linaro.org>
References: <1391407232-4623-1-git-send-email-takahiro.akashi@linaro.org>
 <1393319784-2758-1-git-send-email-takahiro.akashi@linaro.org>
 <1393319784-2758-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140225145347.GA23136@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 09:16:24AM +0000, AKASHI Takahiro wrote:
> Currently AUDITSYSCALL has a long list of architecture depencency:
>        depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML ||
> 		SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT) || ALPHA)
> The purpose of this patch is to replace it with HAVE_ARCH_AUDITSYSCALL
> for simplicity.

Looks sensible to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
