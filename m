From: george.cherian@ti.com (George Cherian)
Date: Mon, 28 Apr 2014 18:28:07 +0530
Subject: [PATCH 4/6] drivers: net: cpsw: Enable Annexe F Time sync
In-Reply-To: <20140428075530.GA8371@netboy>
References: <1398658225-25873-1-git-send-email-george.cherian@ti.com>
 <1398658225-25873-5-git-send-email-george.cherian@ti.com>
 <20140428075530.GA8371@netboy>
Message-ID: <535E505F.3010302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/28/2014 1:25 PM, Richard Cochran wrote:
> On Mon, Apr 28, 2014 at 09:40:23AM +0530, George Cherian wrote:
>> Enable the Annex F Time Sync explicitly for DRA7x and AM4372.
>> With this enabled the L2 PTP is working.
> L2 works fine without this bit. If this is needed for V3 hardware,
> then it should have its own code variant.
okay
>   
>> while at that rename TS_BIT8 to TS_TTL_NONZERO
> Is this bit finally documented for am335x?
Not for am335x, but for other SoC's it s documented.
> Thanks,
> Richard
>


-- 
-George
