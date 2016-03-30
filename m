From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 30 Mar 2016 14:36:14 +0200
Subject: [PATCH 2/7] ARM: dts: skeleton: add unit name to memory node
In-Reply-To: <20160330110611.GB25354@leverpostej>
References: <1459290646-3592-1-git-send-email-manabian@gmail.com>
 <1459290646-3592-3-git-send-email-manabian@gmail.com>
 <20160330110611.GB25354@leverpostej>
Message-ID: <CAGhQ9VxoWQG3g-9o63yUCaTRuivN=gikA61MeAWmvGa5vka3Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 30 March 2016 at 13:06, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Mar 30, 2016 at 12:30:41AM +0200, Joachim Eastwood wrote:
>> Add unit name to memory to remove the following warning:
>>  Warning (unit_address_vs_reg): Node /memory has a reg or ranges
>>                               property, but no unit name
>
> If anything, it would be better to get rid of the memory node from the
> skeleton DTs.

Yes, I agree and as Vladimir notes just by adding a unit name we
create duplicate memory nodes.

I'll send an updated patch set once Rob has a change to look at it also.


> For DTs which have a memory node there's no problem, and DTs which
> expect a bootlaoder to fill things in have a logical place to document
> that fact.

I'll take a look at which DTs that currently doesn't have a memory and add it.


Thanks for looking.


regards,
Joachim Eastwood
