From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 30 Oct 2016 16:26:48 +0100
Subject: [PATCH 1/2] DT: binding: bcm2835-mbox: fix address typo in example
In-Reply-To: <1477505640-26658-1-git-send-email-stefan.wahren@i2se.com>
References: <1477505640-26658-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <b387fb23-8ebe-bd12-631f-4b6e42a5ecde@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 26.10.2016 um 20:13 schrieb Stefan Wahren:
> The address of the mailbox node in the example has a typo.
> So fix it accordingly.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: d4b5c782b9f4 ("dt/bindings: Add binding for the BCM2835 mailbox driver")
> ---
>  .../bindings/mailbox/brcm,bcm2835-mbox.txt         |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
