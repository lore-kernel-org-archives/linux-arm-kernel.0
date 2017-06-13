From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 13 Jun 2017 11:36:52 +0200
Subject: [PATCH v4 2/2] arm: dts: Add Mediatek MT2701 i2c device node
In-Reply-To: <1497268468.930.26.camel@mhfsdcap03>
References: <1495784107-6711-1-git-send-email-jun.gao@mediatek.com>
 <1495784107-6711-3-git-send-email-jun.gao@mediatek.com>
 <1497268468.930.26.camel@mhfsdcap03>
Message-ID: <dbfcfd5b-8812-8df2-40dc-42e889577c9a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/06/17 13:54, Jun Gao wrote:
> On Fri, 2017-05-26 at 15:35 +0800, Jun Gao wrote:
>> From: Jun Gao <jun.gao@mediatek.com>
>>
>> Add MT2701 i2c device node.
>>
>> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
>> ---
>>   arch/arm/boot/dts/mt2701-evb.dts | 42 ++++++++++++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/mt2701.dtsi    | 42 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 84 insertions(+)
[...]
> 
> Dear Matthias,
> 
> Could you take this patch together with
> [PATCH v4 1/2]dt-bindings: i2c: Add Mediatek MT2701 i2c binding ?
> 
> Thanks!
> 

They are both included in the pull request I send [1] [2], or do I miss 
something?

Regards,
Matthias

[1] 
https://github.com/mbgg/linux-mediatek/commit/729b7f8dbdaff270c53052897ea06486221a49a2
[2] 
https://github.com/mbgg/linux-mediatek/commit/c6c301d3ff7531894257acc4f4a73928a109bda1
