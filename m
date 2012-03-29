From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 29 Mar 2012 16:36:11 +0200
Subject: [GIT PULL] pull request from arch-pxa git on fixes branch
In-Reply-To: <CAOesGMgxq-HEeKSPvaW-kTLqNyDJUUmG0OEpockMBNninQL0wQ@mail.gmail.com>
References: <CAN1soZytJ-CxepQAZn5oZ06=ezTQ85O-iC7tUDOeWqi=zpuf8A@mail.gmail.com>
 <4F732D14.3020803@compulab.co.il>
 <CAOesGMgxq-HEeKSPvaW-kTLqNyDJUUmG0OEpockMBNninQL0wQ@mail.gmail.com>
Message-ID: <4F74735B.7060000@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/12 19:12, Olof Johansson wrote:
> Hi,
> 
> On Wed, Mar 28, 2012 at 8:24 AM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> 
>> Can Paul's patch [1] be included in this or later request?
>>
>> Thanks.
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/091750.html
> 
> Yes, Haojian, please add that to the branch (with the proposed fixups)
> as well so we can pick it up and send it in ASAP. Both are broken
> today in Russell's PXA defconfig.
> 
> There is one more failure as well, that I haven't seen a patch posted for:
> 
> arch/arm/mach-pxa/cm-x300.c:716:3: error: unknown field 'dev'
> specified in initializer

Thanks for spotting I will look into this first thing tomorrow morning...
Sorry, I can't do it earlier...


-- 
Regards,
Igor.
