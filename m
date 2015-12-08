From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 8 Dec 2015 09:43:13 +0200
Subject: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
In-Reply-To: <20151208001943.GT23396@atomide.com>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
 <20151208001943.GT23396@atomide.com>
Message-ID: <56668A11.3000408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2015 02:19 AM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [151204 02:46]:
>> +
>> +			ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
>> +				   <&edma_tptc2 0>;
>> +
>> +			ti,edma-memcpy-channels = /bits/ 16 <20 21>;
> 
> Is this safe to change to just ti,edma-memcpy-channels = <20 21> as
> suggested by Arnd?

The binding document for the eDMA and the driver also needs update to be able
to handle this change.

-- 
P?ter
