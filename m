From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 19:05:15 -0400
Subject: [PATCH v2 1/4] clocksource: armada-370-xp: Add missing clock
 enable
In-Reply-To: <1414248522-16055-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1414248522-16055-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141101230515.GG3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On Sat, Oct 25, 2014 at 11:48:39AM -0300, Ezequiel Garcia wrote:
> This commit makes sure the timer clock is prepared and enabled
> before retrieving its rate.
> 
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/clocksource/time-armada-370-xp.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
