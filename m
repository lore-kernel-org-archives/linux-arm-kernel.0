From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 23 Mar 2016 11:34:44 +0100
Subject: [PATCH v3 2/2] documentation: Fix pinctrl documentation for
 Meson8 / Meson8b
In-Reply-To: <1458724440-32228-3-git-send-email-carlo@caione.org>
References: <1458724440-32228-1-git-send-email-carlo@caione.org>
 <1458724440-32228-3-git-send-email-carlo@caione.org>
Message-ID: <56F27144.9070805@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.03.2016 um 10:14 schrieb Carlo Caione:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Fix pin controller documentation introducing the new compatibles for
> the pinctrl drivers specific for aobus / cbus.
> 
> This is needed because we have changed the pin controller driver: we
> have now a single specialized pinctrl driver / compatible for each bus
> the controller is attached to, instead of one single driver dealing with
> all the controllers we have on different buses.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  .../devicetree/bindings/pinctrl/meson,pinctrl.txt  | 38 ++++------------------
>  1 file changed, 7 insertions(+), 31 deletions(-)

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
