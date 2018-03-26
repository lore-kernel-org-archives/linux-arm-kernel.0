From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 26 Mar 2018 18:27:06 +0300
Subject: [PATCH] arm64: dts: renesas: v3msk: add EtherAVB pins
In-Reply-To: <20180326090146.7f7esysp5uhd5z3i@verge.net.au>
References: <c42c9e9a-8fe8-5cad-0eeb-0c1fbd09f83c@cogentembedded.com>
 <20180326090146.7f7esysp5uhd5z3i@verge.net.au>
Message-ID: <73ffe546-d7c5-ced6-d75b-be36f2457067@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2018 12:01 PM, Simon Horman wrote:

>> Add the (previously omitted) EtherAVB pin data to the V3M Starter Kit
>> board's device tree.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> The patch is against the 'renesas-devel-20180314-v4.16-rc5' tag of Simon's
>> 'renesas.git repo. It depends on the R8A77970 PFC driver patch adding EtherAVB
>> pin groups (posted yesterday) in order to work properly...
> 
> Thanks, I have marked this as deferred, please either:
> * repost or ping me once the dependency is in an RC release or;
> * let me know that its safe to apply this change - that is, it won't cause
>   a regression - without the dependency

   I'm seeing this patch merged under the today's devel tag -- please undo the merge
as the PFC pre-requisite patch haven't hit Linus' repo yet. 

MBR, Sergei
