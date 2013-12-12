From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Thu, 12 Dec 2013 10:01:44 -0400
Subject: [PATCH 12/15] thermal: rcar-thermal: Enable driver compilation
 with COMPILE_TEST
In-Reply-To: <5903007.OehDdPcG2U@avalon>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <5903007.OehDdPcG2U@avalon>
Message-ID: <52A9C1C8.2030907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-12-2013 08:50, Laurent Pinchart wrote:
> Hi Zhang and Eduardo,
> 
> Could you please pick this patch up for v3.14 ?

Yes Laurent, I can pick it.

> 
> On Wednesday 27 November 2013 02:18:34 Laurent Pinchart wrote:
>> This helps increasing build testing coverage.
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
>> Cc: linux-pm at vger.kernel.org
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> Acked-by: Simon Horman <horms@verge.net.au>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

>> ---
>>  drivers/thermal/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index f35a1f7..661cafc 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -121,7 +121,7 @@ config SPEAR_THERMAL
>>
>>  config RCAR_THERMAL
>>  	tristate "Renesas R-Car thermal driver"
>> -	depends on ARCH_SHMOBILE
>> +	depends on ARCH_SHMOBILE || COMPILE_TEST
>>  	help
>>  	  Enable this to plug the R-Car thermal sensor driver into the Linux
>>  	  thermal framework.


-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/d2cc23db/attachment-0001.sig>
