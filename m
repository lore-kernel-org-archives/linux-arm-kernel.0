From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 25 Sep 2017 10:45:33 +0200
Subject: [PATCH 2/3] clocksource: owl: pr_err() strings should end with
 newlines
In-Reply-To: <1506327401-30521-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1506327401-30521-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1506327401-30521-3-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <791991d7-dee6-89f0-f827-b1ce5e7a4013@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.09.2017 um 10:16 schrieb Arvind Yadav:
> pr_err() messages should terminated with a new-line to avoid
> other messages being concatenated onto the end.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/clocksource/owl-timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
