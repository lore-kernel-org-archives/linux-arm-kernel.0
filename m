From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 20 Dec 2013 15:15:56 +0400
Subject: [PATCH v3 00/10] ARM: sa1100: improve irq handling
In-Reply-To: <CACRpkdZS+sd+2=_SQ3k31qwMdV+_towgBpAGih9uhaXofwhY=g@mail.gmail.com>
References: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdZS+sd+2=_SQ3k31qwMdV+_towgBpAGih9uhaXofwhY=g@mail.gmail.com>
Message-ID: <CALT56yOHPTCBTcWWC50eKtx0G0tkc4x_zkkAfppJU0WA2ZEyCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Dec 20, 2013 at 1:25 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Dec 15, 2013 at 5:28 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>
>> Please review my third attempts on touching the sa1100 irq code. I have split
>> changes to a serie of small, simple and easy to review patches, with each one
>> touching only one aspect of irq handling code for sa1100.
>
> I've tested this series on the H3600 and it works flawlessly.
>
> For the series:
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Thank you!

>
> I guess you best way forward it to put patches into Russell's
> patch tracker or send him a pull request.

Russell, would you review these patches here, or I'd better put them
to patch tracker?

-- 
With best wishes
Dmitry
