From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Apr 2014 20:43:01 -0400
Subject: [PATCH 0/2] ARM: mvebu: board-v7 cleanup
In-Reply-To: <1397925170-8202-1-git-send-email-gregory.clement@free-electrons.com>
References: <1397925170-8202-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140426004301.GP28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 19, 2014 at 06:32:48PM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> These two patches doesn't really change the behaviour of the code, but
> will help to make it more readable and maintainable.
> 
> Thanks
> 
> Gregory CLEMENT (2):
>   ARM: mvebu: remove unnecessary ifdef around l2x0_of_init
>   ARM: mvebu: fix the name of the parameter used in mvebu_get_soc_id
> 
>  arch/arm/mach-mvebu/board-v7.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied both to mvebu/soc with Thomas' Reviewed-by.

thx,

Jason.
