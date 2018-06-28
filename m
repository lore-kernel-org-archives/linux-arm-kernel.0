From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jun 2018 17:01:35 +0100
Subject: [PATCH v2 0/4] I-side fixes
In-Reply-To: <1529656278-878-1-git-send-email-will.deacon@arm.com>
References: <1529656278-878-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180628160135.cjjtwpq5jesl3ucn@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 09:31:14AM +0100, Will Deacon wrote:
> Will Deacon (4):
>   arm64: Avoid flush_icache_range() in alternatives patching code
>   arm64: Remove unnecessary ISBs from set_{pte,pmd,pud}

I'm merging these two patches for -rc3. I'll leave the other two to you
for 4.19.

-- 
Catalin
