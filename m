From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Mon, 2 Oct 2017 21:36:23 +0200
Subject: [PATCH] arm: fix sparse flags for build on 64bit machines
In-Reply-To: <20170929183708.GJ457@codeaurora.org>
References: <20170726013020.GL2146@codeaurora.org>
 <20170726084305.38537-1-luc.vanoostenryck@gmail.com>
 <e4e7c448-5176-34af-0d88-ee7325d666f0@codeaurora.org>
 <18b6d290-da61-c838-5d46-d4a81740bc16@codeaurora.org>
 <20170929183708.GJ457@codeaurora.org>
Message-ID: <CAMHZB6HP7RjvhZZdE=YD_EV3qeAvAAjfd3sikS+=s9xUzfXuhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 8:37 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 08/07, Stephen Boyd wrote:
>> On 07/26/2017 11:26 AM, Stephen Boyd wrote:
>> > On 07/26/2017 01:43 AM, Luc Van Oostenryck wrote:
>> >> By default sparse uses the characteristics of the build
>> >> machine to infer things like the wordsize.
>> >> This is fine when doing native builds but for ARM it's,
>> >> I suspect, very rarely the case and if the build are done
>> >> on a 64bit machine we get a bunch of warnings like:
>> >>   'cast truncates bits from constant value (... becomes ...)'
>> >>
>> >> Fix this by adding the -m32 flags for sparse.
>> >>
>> >> Reported-by: Stephen Boyd <sboyd@codeaurora.org>
>> >> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> > Tested-by: Stephen Boyd <sboyd@codeaurora.org>
>> >
>> >
>>
>> Russell, is this good to put in the patch tracker?
>>
>>
>> Luc, can you submit this via Russell's patch tracking system (see
>> http://www.arm.linux.org.uk/developer/patches/info.php)?
>>
>
> It's been a while, and this isn't in linux-next or the patch
> tracker from what I can tell. I'll forward it along if nothing
> happens in the next couple days.

Sorry, I had forgot about it.
It's now added as patch 8701/1 in Russell's system.

-- Luc
