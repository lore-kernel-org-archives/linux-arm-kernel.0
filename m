From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 18 Jun 2017 22:18:39 +0200
Subject: [PATCH v4 03/28] dt-bindings: timer: Document Owl timer
In-Reply-To: <20170606005426.26446-4-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-4-afaerber@suse.de>
Message-ID: <ec380c22-c902-80e7-3672-f4a11ceecc3a@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> The Actions Semi S500 SoC contains a timer block with two 2 Hz and two
> 32-bit timers. The S900 SoC timer block has four 32-bit timers.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4:
>  * Changed interrupt names to lower-case (Mark)
>  
>  v2 -> v3:
>  * Adopted interrupt-names
>  * Changed compatible for S500
>  * Added S900 compatible and interrupt names
>  
>  v2: new
>  
>  .../devicetree/bindings/timer/actions,owl-timer.txt  | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer.txt

Thanks, applied to linux-actions.git v4.13/dt branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/dt

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
