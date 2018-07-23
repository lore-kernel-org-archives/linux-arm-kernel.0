From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 23 Jul 2018 19:14:28 +0300
Subject: [PATCH] arm64: dts: renesas: r8a77980: add RWDT support
In-Reply-To: <20180723160827.ziuivshq2mtagexq@verge.net.au>
References: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
 <175a491f-a827-4a92-1884-2f1490d38a52@cogentembedded.com>
 <20180723160827.ziuivshq2mtagexq@verge.net.au>
Message-ID: <4eb91e29-9c2f-6f7c-2b3c-983e41430e26@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2018 07:08 PM, Simon Horman wrote:

>> Describe RWDT in the R8A77980 SoC device tree.
>>
>> Enable RWDT on the Condor and V3H Starter Kit boards.
>>
>> Based on the original (and large) patch by Vladimir Barinov.
>>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> The patch is against the 'renesas-devel-20180720-v4.18-rc5' of Simon Horman's
>> 'renesas.git' repo.  It depends on Geert Uytterhoeven's clock driver patches
>> (adding the RWDT clock) in order to work...
> 
> But it is safe to apply without those patches, right?

   The RWDT driver should just fail to probe with -ENOENT. 

> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

   TY!

MBR, Sergei
