From: davem@davemloft.net (David Miller)
Date: Wed, 30 May 2012 17:52:41 -0400 (EDT)
Subject: [PATCH 19/22] net/smsc911x: Repair broken failure paths
In-Reply-To: <CACRpkdY=2j4gRGO4P4RfQDKo+sgV4akAQ6dpP4RbL+XywNCC5A@mail.gmail.com>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-20-git-send-email-lee.jones@linaro.org>
 <CACRpkdY=2j4gRGO4P4RfQDKo+sgV4akAQ6dpP4RbL+XywNCC5A@mail.gmail.com>
Message-ID: <20120530.175241.2087666784890215382.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 30 May 2012 15:16:39 +0800

> On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
>> Current failure paths attempt to free resources which we failed to request
>> and disable resources which we failed to enable ones. This leads to kernel
>> oops/panic. This patch does some simple re-ordering to prevent this from
>> happening.
>>
>> Cc: netdev at vger.kernel.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.
