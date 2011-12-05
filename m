From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 05 Dec 2011 12:36:43 +0100
Subject: [PATCH v2] net/macb: add DT support
In-Reply-To: <20111202.125832.1208514279272697863.davem@davemloft.net>
References: <1322846050-4543-1-git-send-email-nicolas.ferre@atmel.com>
 <1322847782-22650-1-git-send-email-nicolas.ferre@atmel.com>
 <20111202.125832.1208514279272697863.davem@davemloft.net>
Message-ID: <4EDCACCB.4010608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2011 06:58 PM, David Miller :
> From: Nicolas Ferre<nicolas.ferre@atmel.com>
> Date: Fri,  2 Dec 2011 18:43:02 +0100
>
>> From: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
>>
>> Allow the device tree to provide the mac address and the phy mode.
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
>> [nicolas.ferre at atmel.com: change "compatible" node property, doc and DT hwaddr]
>> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
>> Cc: Jamie Iles<jamie@jamieiles.com>
>> ---
>> v2: modify macb_get_hwaddr_dt() parameter
>
> You'll have to respin these two macb patches, as they don't apply properly
> to the net-next tree which is where they should be targetted.

David,

In fact, the patches are designed to be added on top of Jamie's rework 
of the macb driver that is now in Arnd's "arm-soc" git tree (for-next 
branch). You discussed with him here:

http://www.spinics.net/lists/arm-kernel/msg118717.html

Should I go this path also or wait for this material to be merged and 
update on net-next at this time (after 3.3 merge window...)?

Best regards,
-- 
Nicolas Ferre
