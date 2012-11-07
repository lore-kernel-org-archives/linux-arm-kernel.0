From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 7 Nov 2012 17:43:24 -0600
Subject: [PATCH V2 03/14] ARM: OMAP3+: Implement timer workaround for
 errata i103 and i767
In-Reply-To: <509AEEA4.80804@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
 <1352314890-22224-4-git-send-email-jon-hunter@ti.com> <509ADD28.20707@ti.com>
 <509AEEA4.80804@ti.com>
Message-ID: <509AF21C.7020105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 November 2012 05:28 PM, Jon Hunter wrote:
>
> On 11/07/2012 04:14 PM, Santosh Shilimkar wrote:
>
>> Looks sensible considering alternative WAs.
>>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Thanks. With further thought I think that it would be best to combine
> patches #2 and #3. Really the main motivation here is the errata
> workaround and without actually benchmarking the timer read I should
> not claim the improvement in overhead as stated in patch #2. So I
> have combined #2 and #3 and updated the changelog/comments
> appropriately. Let me know if you guys are ok with this.
>
Yep. Sounds good.

Regards
Santosh
