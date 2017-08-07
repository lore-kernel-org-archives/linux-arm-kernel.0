From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 7 Aug 2017 12:56:14 +0300
Subject: [PATCH] pinctrl-st: fix of_irq_to_resource() result check
In-Reply-To: <CACRpkdbLTr+zcwXaanr2HJHp=e-AauDx_hZ=dd4zjmAKsRdOtQ@mail.gmail.com>
References: <20170729180744.873303067@cogentembedded.com>
 <CACRpkdbLTr+zcwXaanr2HJHp=e-AauDx_hZ=dd4zjmAKsRdOtQ@mail.gmail.com>
Message-ID: <7c73ec8f-c261-d92b-637d-8383d56750b1@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/7/2017 12:05 PM, Linus Walleij wrote:

>> of_irq_to_resource() has recently been fixed to return negative error #'s
>> along with 0 in case of failure, however the ST driver still only regards
>> 0 as failure indication -- fix it up.
>>
>> Fixes: 7a4228bbff76 ("of: irq: use of_irq_get() in of_irq_to_resource()")
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Patch applied.

    Again, not seeing it...

> Yours,
> Linus Walleij

MBR, Sergei
