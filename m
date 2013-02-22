From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Feb 2013 18:30:02 +0100
Subject: [PATCH v4 00/11] enhance DT support on gpio pxa
In-Reply-To: <CAD6h2NTe5K=6fKkm=n=ZawjhoR+_sOe5McX2soT7_Af22wKvDg@mail.gmail.com>
References: <1361290948-16669-1-git-send-email-haojian.zhuang@linaro.org>
 <5124DE3C.2050701@compulab.co.il>
 <CAD6h2NTe5K=6fKkm=n=ZawjhoR+_sOe5McX2soT7_Af22wKvDg@mail.gmail.com>
Message-ID: <CACRpkdYXZSTHdbGrSw5c8rHnbkNANU44ketmaOfKfX3+ixjeFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 4:58 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

>> Linus, I wonder if you still can get this into 3.9?
>>
> Now it's a little late. So let's see them in 3.10.

Sorry no chance for v3.9.

But I'm sad that you dropped the irqdomain patches. I'd really
like to have that as part of the patch set.

I'm not merging anything right now during the merge window,
and I'm travelling as well, so I recommend you make a v5 which
is complete in the sense that it includes a patch that switches
the result to use irqdomain as well.

Sorry for all the back-and-forth. :-/

Yours,
Linus Walleij
