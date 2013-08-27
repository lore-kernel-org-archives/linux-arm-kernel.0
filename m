From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 27 Aug 2013 09:42:34 +0200
Subject: [PATCH 0/2] net/cadence/macb: add support for dt phy definition
In-Reply-To: <20130826.160450.2176892065062148718.davem@davemloft.net>
References: <1377186980-21902-1-git-send-email-b.brezillon@overkiz.com>
 <20130826.160450.2176892065062148718.davem@davemloft.net>
Message-ID: <521C586A.7080604@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dave,

On 26/08/2013 22:04, David Miller wrote:
> From: Boris BREZILLON <b.brezillon@overkiz.com>
> Date: Thu, 22 Aug 2013 17:56:20 +0200
>
>> This patch series adds support for ethernet phy definition using device
>> tree.
>>
>> This may help in moving some at91 boards to dt (some of them define an
>> interrupt pin).
>>
>> Tested on samad31ek.
> Series applied to net-next, thanks.
Could you apply, the 3rd version of this series instead ?

It fixes one bug when no phy is discovered and use the appropriate address
for the phy dt node.

Sorry for the inconvenience.

Best Regards,

Boris
