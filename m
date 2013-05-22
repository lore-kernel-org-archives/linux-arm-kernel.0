From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 22 May 2013 18:19:28 +0400
Subject: [PATCH FOR v3.10 v2] ARM: shmobile: kzm9g-reference: Update CMT
 clocksource rating to 80
In-Reply-To: <1369232020-22681-1-git-send-email-horms+renesas@verge.net.au>
References: <1369232020-22681-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <519CD3F0.7050002@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22-05-2013 18:13, Simon Horman wrote:

> Update the CMT clocksource rating from 125 to 80.

> This resolves a boot-failure regression for kzm9g-reference in v3.10-rc1
> introduced by f7db706b132f11c79ae1d74b2382e0926cf31644 ("ARM: 7674/1: smp:
> Avoid dummy clockevent being preferred over real").

> The patch noted above reduces the rating of dummy clockevent from 400 to 100.
> This patch reduces the rating of CMT so that it is once again less than that
> of the dummy clockevent.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

> ---

> I also plan to reduce the rating of the STI clocksource to less than 100.
> However, as I am not aware of any problems relating to STI in v3.10-rc
> my plan is to update STI in the v3.11 timeframe.
> ---
>   arch/arm/mach-shmobile/setup-sh73a0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

    BTW, shouldn't the subject be "ARM: shmobile: sh73a0: Update CMT 
clocksource rating to 80"?

WBR, Sergei
