From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 4 Jul 2012 16:04:02 +0800
Subject: [PATCH] ARM: mmp: remove mach/gpio-pxa.h
In-Reply-To: <CAMPhdO-goJK9JATj_pxbBhDFyN+ZFEHUd6PbRiMeb6RkU1OBmQ@mail.gmail.com>
References: <1341265214.1911.151.camel@x61.thuisdomein>
 <CAMPhdO-goJK9JATj_pxbBhDFyN+ZFEHUd6PbRiMeb6RkU1OBmQ@mail.gmail.com>
Message-ID: <CAN1soZynjS8+0eq7pv=tkTcw4-52yvA-ygEmbKKY0b4LR2nQ0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2012 at 2:30 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Tue, Jul 3, 2012 at 5:40 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
>> Commit 157d2644cb0c1e71a18baaffca56d2b1d0ebf10f ("ARM: pxa: change gpio
>> to platform device") removed all includes of mach/gpio-pxa.h. It kept
>> this unused header in the tree. Using it can't work, as it itself
>> includes the non-existent header plat/gpio-pxa.h. This header can safely
>> be removed.
>>
>> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
>
> Acked-by: Eric Miao <eric.y.miao@gmail.com>
>
Applied

Regards
Haojian
