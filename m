From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 05 May 2010 13:57:07 +0400
Subject: [PATCH] ARM: Gemini: fix compiler error in copypage-fa.c
In-Reply-To: <1272983655-18408-1-git-send-email-ulli.kroll@googlemail.com>
References: <1272983655-18408-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <4BE140F3.3070901@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Hans Ulli Kroll wrote:

> Fix compiler error in copypage-fs.c
>   

   You've called it copypage-fa.c in the subject.

> missing struct vm_area_struct *vma in function
> fa_copy_user_highpage
>
> Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> ---
>  arch/arm/mm/copypage-fa.c |    2 +-
>   

   And the file name is indeed copypage-fa.c...

WBR, Sergei
