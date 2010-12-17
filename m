From: nm@ti.com (Nishanth Menon)
Date: Fri, 17 Dec 2010 07:18:08 -0600
Subject: [PATCH 1/7] OMAP3: remove unused code from the ASM sleep code
In-Reply-To: <1292580506-4421-2-git-send-email-j-pihet@ti.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
	<1292580506-4421-2-git-send-email-j-pihet@ti.com>
Message-ID: <4D0B6310.2010104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jean.pihet at newoldbits.com had written, on 12/17/2010 04:08 AM, the 
following:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Remove unused code:
> - macros,
> - variables,
> - unused semaphore locking API. This API shall be added back
>   when needed,
> - infinite loops for debug.
> 
> Tested on N900 and Beagleboard with full RET and OFF modes,
> using cpuidle and suspend.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Reviewed-by: Nishanth Menon <nm@ti.com>
Tested-by: Nishanth Menon<nm@ti.com>
Tested on:
SDP3630
SDP3430
Test script:
http://pastebin.mozilla.org/889933


-- 
Regards,
Nishanth Menon
