From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 31 May 2017 14:05:45 +0200
Subject: [PATCH 1/4] dt-bindings: mtk-sysirq: Correct bindings for
 supported SoCs
In-Reply-To: <20170530231320.yi4s5ib3jpyo7xwk@rob-hp-laptop>
References: <20170522094021.7837-1-matthias.bgg@gmail.com>
 <20170530231320.yi4s5ib3jpyo7xwk@rob-hp-laptop>
Message-ID: <1d0ca3f1-29c2-09ee-6e18-48a808871ed3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 31/05/17 01:13, Rob Herring wrote:
> On Mon, May 22, 2017 at 11:40:18AM +0200, Matthias Brugger wrote:
>> All SoCs supported up to now rely on the fallback binding of mt6577.
>> Fix the binding description to reflect this.
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>   .../interrupt-controller/mediatek,sysirq.txt       | 24 +++++++++++-----------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Thanks!

Pushed to v4.12-next/dts64
