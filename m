From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 5 Aug 2014 15:14:17 +0100
Subject: [PATCH v4] efi: implement mandatory locking for UEFI Runtime
 Services
In-Reply-To: <CAKv+Gu8tdHE_iE-1nv6d0TuuUTmpL5-rB3+Exht7jAdE+1jW=A@mail.gmail.com>
References: <1407168960-30128-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140805120332.GO15082@console-pimps.org>
 <CAKv+Gu8tdHE_iE-1nv6d0TuuUTmpL5-rB3+Exht7jAdE+1jW=A@mail.gmail.com>
Message-ID: <20140805141417.GQ15082@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 05 Aug, at 02:14:38PM, Ard Biesheuvel wrote:
> 
> """
> Some of the assumptions underlying the decision whether locks are
> needed or not (e.g., SetVariable() against ResetSystem()) may not
> apply universally to all [new] architectures that implement UEFI.
> Rather than try to reason our way out of this, let's just implement at
> least what the spec requires in terms of locking.
> """

Thanks Ard, I've picked this commit up for the 'next' branch.

-- 
Matt Fleming, Intel Open Source Technology Center
