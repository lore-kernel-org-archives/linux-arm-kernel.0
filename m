From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 1 Jul 2012 15:27:25 +0800
Subject: [PATCH] ARM: pxa: remove eseries.h
In-Reply-To: <CAMPhdO99maVhhpzLC_v9ZBdt=2=KNAg4oEn+wbQYmhYTEtTGgw@mail.gmail.com>
References: <1339505386.30984.123.camel@x61.thuisdomein>
 <CAMPhdO99maVhhpzLC_v9ZBdt=2=KNAg4oEn+wbQYmhYTEtTGgw@mail.gmail.com>
Message-ID: <CAN1soZxwF1sw-w6UQsCNo_FQ-Soq9b3J8XiF+WGYxezn8dix9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 9:19 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Tue, Jun 12, 2012 at 8:49 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
>> Commit e478fe4cd50b86e95fadc415438b63fa94060b7d ("[ARM] pxa: merge all
>> eseries board code into eseries.c") removed all six files that included
>> eseries.h. Everything that this header provides is now either local to
>> eseries.c or entirely unused. It was apparently just an oversight to
>> keep this header. This header can safely be removed.
>>
>> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
>
> That was long time ago. I'm basically good with the removal. Haojian, could
> you give a simple test maybe?
>
Applied

Regards
Haojian
