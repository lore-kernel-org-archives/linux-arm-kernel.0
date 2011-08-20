From: kmpark@infradead.org (Kyungmin Park)
Date: Sat, 20 Aug 2011 15:34:32 +0900
Subject: [PATCH 0/4] ARM: SAMSUNG: Add support CPU ID and Rev. at runtime
In-Reply-To: <1313816759-14564-1-git-send-email-kgene.kim@samsung.com>
References: <1313816759-14564-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAH9JG2VLzgdn_aD4eTsx8TpDAOvQHqcC8HCJtPvScbe+OBY+Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good

change the mind to use the runtime soc detection. it's really required
feature. but previous time Ben did'n like it.
https://lkml.org/lkml/2010/3/30/831

I'm still prefer to use it when only early boot time if possible

and another mail said cpu_is_* doesn't proper name, soc_is_* is better.


Thank you,
Kyungmin Park

On Sat, Aug 20, 2011 at 2:05 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patch adds support handling of CPU ID and varialble silicon revision
> at runtime.
>
> [PATCH 1/4] ARM: SAMSUNG: Add support for detecting CPU at runtime
> [PATCH 2/4] ARM: S5P64X0: Use cpu_is_s5p64x0() to distinguish cpu at runtime
> [PATCH 3/4] ARM: SAMSUNG: Add support for handling of cpu revision
> [PATCH 4/4] ARM: EXYNOS4: Use samsung_rev() to distinguish silicon revision
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
