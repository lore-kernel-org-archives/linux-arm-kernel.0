From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 13 Oct 2017 16:50:43 +0200
Subject: [PATCH v4 0/9] Mediatek MT2712 clock and scpsys support
In-Reply-To: <20171012224540.GE18706@codeaurora.org>
References: <1505793630-12590-1-git-send-email-weiyi.lu@mediatek.com>
 <20171012224540.GE18706@codeaurora.org>
Message-ID: <ac7940d1-e23d-add2-b4b6-bd7cf66fea34@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/13/2017 12:45 AM, Stephen Boyd wrote:
> On 09/19, Weiyi Lu wrote:
>> This series is based on v4.14-rc1 and composed of
>> clock control (PATCH 1-4) and scpsys control (PATCH 5-9)
> 
> What's the merge plan? Can I apply the clk ones to clk tree and
> ignore the rest?
> 

Yes, please do so. I'll take scpsys, which depends on the clock patches.

Regards,
Matthias
