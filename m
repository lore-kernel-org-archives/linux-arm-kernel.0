From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 04:09:49 +0200
Subject: [PATCH v4 21/28] ARM: dts: s500: Set CPU enable-method
In-Reply-To: <20170606005426.26446-22-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-22-afaerber@suse.de>
Message-ID: <f5904acc-7d23-39c0-d6bc-8077e9884915@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> Use a custom S500 enable-method for all CPUs.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4: Unchanged
>  
>  v3: new
>  
>  arch/arm/boot/dts/s500.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to linux-actions.git v4.13/dt branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/dt

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
