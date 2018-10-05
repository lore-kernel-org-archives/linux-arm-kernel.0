From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Oct 2018 10:29:04 +0100
Subject: [PATCH] Fix typo in a comment in arch/arm64/mm/kasan_init.c
In-Reply-To: <20181004160646.3348-1-kyrylo.tkachov@arm.com>
References: <20181004160646.3348-1-kyrylo.tkachov@arm.com>
Message-ID: <20181005092903.GA12355@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2018 at 05:06:46PM +0100, Kyrylo Tkachov wrote:
> "bellow" -> "below"
> 
> The recommendation from kegel.com/kerspell is to only fix the howlers.
> "Bellow" is a synonym of "howl" so this should be appropriate.
> 
> Signed-off-by: Kyrylo Tkachov <kyrylo.tkachov@arm.com>
> ---
>  arch/arm64/mm/kasan_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Catalin should be able to pick this up for 4.20.

Will
