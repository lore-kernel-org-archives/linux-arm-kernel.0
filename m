From: paul.burton@mips.com (Paul Burton)
Date: Tue, 9 Oct 2018 23:01:40 +0000
Subject: [PATCH] memblock: stop using implicit alignement to
 SMP_CACHE_BYTES
In-Reply-To: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-ID: <20181009230137.rju3lm2saou5xsa4@pburton-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Fri, Oct 05, 2018 at 12:07:04AM +0300, Mike Rapoport wrote:
> When a memblock allocation APIs are called with align = 0, the alignment is
> implicitly set to SMP_CACHE_BYTES.
> 
> Replace all such uses of memblock APIs with the 'align' parameter explicitly
> set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
> memblock internal allocation functions.
> 
>%
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

  Acked-by: Paul Burton <paul.burton@mips.com> # MIPS part

Thanks,
    Paul
