From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 20 Jun 2016 15:11:54 +0300
Subject: [PATCH 01/28] crypto: omap-aes: Fix registration of algorithms
In-Reply-To: <20160607104821.GA520@gondor.apana.org.au>
References: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
 <1464771389-10640-2-git-send-email-t-kristo@ti.com>
 <20160607104821.GA520@gondor.apana.org.au>
Message-ID: <5767DD8A.9010107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/16 13:48, Herbert Xu wrote:
> On Wed, Jun 01, 2016 at 11:56:02AM +0300, Tero Kristo wrote:
>> From: Lokesh Vutla <lokeshvutla@ti.com>
>>
>> Algorithms can be registered only once. So skip registration of
>> algorithms if already registered (i.e. in case we have two AES cores
>> in the system.)
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> Patch applied.  Thanks.
>

Thanks,

Did you check the rest of the series? I only got feedback for this and 
patch #2 on the series, shall I repost the remainder of the series as a 
whole or...?

-Tero
