From: joelf@ti.com (Joel Fernandes)
Date: Mon, 12 Aug 2013 20:08:56 -0500
Subject: [PATCH v3 08/12] dma: edma: Add one more required slot to MAX
 slots
In-Reply-To: <52087921.8040101@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
 <1375719297-12871-9-git-send-email-joelf@ti.com> <52087921.8040101@ti.com>
Message-ID: <52098728.3020308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2013 12:56 AM, Sekhar Nori wrote:
> On Monday 05 August 2013 09:44 PM, Joel Fernandes wrote:
>> We'd now need a separate slot just for the channel and separate
>> ones for the 2 linked sets, so we make adjustments to allocate
>> an extra channel accordingly.
>>
>> Signed-off-by: Joel Fernandes <joelf@ti.com>
> 
> No need for a separate patch for this, just do this in the patch where
> you include the two linked sets.

Ok, I dropped this patch. Anyway, most of this patch has gone away now
because of other changes you suggested.

Thanks,

-Joel
