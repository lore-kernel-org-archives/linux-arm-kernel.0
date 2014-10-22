From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 Oct 2014 15:50:49 +0200
Subject: [PATCH 1/4] clocksource: armada-370-xp: Add missing clock enable
In-Reply-To: <1413984884-20273-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413984884-20273-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141022155049.106d3ee5@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Wed, 22 Oct 2014 10:34:41 -0300, Ezequiel Garcia wrote:
> This commit makes sure the timer clock is prepared and enabled
> before retrieving its rate.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/clocksource/time-armada-370-xp.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
