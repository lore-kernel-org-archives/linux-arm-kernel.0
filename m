From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Wed, 30 Jul 2014 14:19:00 +0200
Subject: [PATCHv7 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk
 to host's quirk
In-Reply-To: <1406514579-3769-6-git-send-email-jh80.chung@samsung.com>
References: <1406514579-3769-1-git-send-email-jh80.chung@samsung.com>
 <1406514579-3769-6-git-send-email-jh80.chung@samsung.com>
Message-ID: <53D8E2B4.5050202@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.07.2014 04:29, schrieb Jaehoon Chung:
> Replaced the "disable-wp" into host's quirks.

"Replace" is wrong here and in $subject. "Relocate"? "Move"?

> (Because the slot-node is removed at dt-file.)

"in dt-file"?

> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |   12 +++++-------
>  include/linux/mmc/dw_mmc.h |    6 ++----
>  2 files changed, 7 insertions(+), 11 deletions(-)

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
