From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 15 Nov 2012 20:10:44 +0800
Subject: [PATCH] ARM: pxa: remove pxa95x support
In-Reply-To: <201211151206.33461.arnd@arndb.de>
References: <1352970366-7154-1-git-send-email-haojian.zhuang@gmail.com>
 <201211151206.33461.arnd@arndb.de>
Message-ID: <CAN1soZzPRCEf1A0pf=138FnOG4XCsjmrudkxtx+eh5TKWL7nyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 8:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 15 November 2012, Haojian Zhuang wrote:
>> PXA95x isn't widely used. And it adds the effort on supporting
>> multiple platform. So remove it.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>
> Looks good to me, thanks for going through this.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Should I apply this straight into the arm-soc tree, or are you
> going to send a pull request?

Yes, please apply it into arm-soc tree directly.

Regards
Haojian
