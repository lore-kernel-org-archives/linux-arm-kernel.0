From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 18 Mar 2018 21:34:49 +0100
Subject: [PATCH v3 01/15] dt-bindings: clock: mediatek: add missing
 required #reset-cells
In-Reply-To: <152123261872.225550.10226809804986023416@swboyd.mtv.corp.google.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
 <7365f2286ff2cebcfb590715cb4a15dedd089046.1518895232.git.sean.wang@mediatek.com>
 <152123261872.225550.10226809804986023416@swboyd.mtv.corp.google.com>
Message-ID: <836d5d6e-eafa-52b8-39dc-6422ebe32d82@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/16/2018 09:36 PM, Stephen Boyd wrote:
> Quoting sean.wang at mediatek.com (2018-02-17 11:54:36)
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> All ethsys, pciesys and ssusbsys internally include reset controller, so
>> explicitly add back these missing cell definitions to related bindings
>> and examples.
>>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: linux-clk at vger.kernel.org
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> 

added to v4.16-next/dts64
Thanks!
