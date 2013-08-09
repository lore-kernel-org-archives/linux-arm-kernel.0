From: cjb@laptop.org (Chris Ball)
Date: Fri, 09 Aug 2013 01:55:44 +0100
Subject: dw_mmc: Does anyone use multiple slots?
In-Reply-To: <CAOesGMjaF2K0CnuWBj7xdXGAQk-XRetBstaQdd9EZzBYrmDjeA@mail.gmail.com>
 (Olof Johansson's message of "Thu, 8 Aug 2013 17:19:44 -0700")
References: <CAD=FV=U3aT1KKtSwAFhYURJJerp70ij8h647=xyV51et4jYipg@mail.gmail.com>
 <CAOesGMjaF2K0CnuWBj7xdXGAQk-XRetBstaQdd9EZzBYrmDjeA@mail.gmail.com>
Message-ID: <86mworfzsf.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 09 2013, Olof Johansson wrote:
> On Thu, Aug 8, 2013 at 5:16 PM, Doug Anderson <dianders@google.com> wrote:
>
>> I guess my overall question is: if there are no actual implementations
>> of multislot, shouldn't we kill it and simplify the code a whole lot?
>> If someone out there has a real multislot device they can step back in
>> and do it more correctly?
>>
>> Of course we need to find someone to actually go through and do the
>> killing of multislot, but finding that person might be easier if there
>> was some agreement that it was good to do.
>
> There clearly seems to be no in-tree users of multislot. If someone
> new comes in, we have the code in the history and can revert the
> removal (or at least use it as reference for re-introduction).
>
> I vote for removing it. It adds really annoying complexity for
> something that nobody uses.

I agree with Olof, for what it's worth.  (The maintainers of the
driver are Jaehoon and Seungwon, though.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
