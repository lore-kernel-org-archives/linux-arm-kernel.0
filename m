From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 16 Jul 2012 13:15:59 -0700
Subject: [PATCH 4/9] ARM: vexpress: Initial common clock support
In-Reply-To: <1342025844.25865.3.camel@hornet>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-5-git-send-email-pawel.moll@arm.com>
 <CACRpkdZGVgO-1jnfK=fpo73ryLDe05R0_hghwBxzDfbBK9jBRA@mail.gmail.com>
 <1342025844.25865.3.camel@hornet>
Message-ID: <CAJOA=zOe79YK06Rq2wmqkyGrHopyDi5ZWB25qL53g_nxu9T-TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 9:57 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> On Wed, 2012-07-11 at 17:51 +0100, Linus Walleij wrote:
>> Hi Pawel,
>>
>> can you please move the vexpress clock implementation to
>> drivers/clk/versatile/clk-vexpress.c as per the pattern from the
>> Integrator rework?
>>
>> Clock drivers go into the drivers/* hierarchy just like any other
>> driver these days.
>
> I will, but I'd rather avoid doing this right now.
>
>> >This is a simple conversion of the existing state and will be
>> > extended (and migrated to drivers/clk) in the near future.
>>
> This patch is only a first step. I'm working now on a major rework of
> the VE control infrastructure, and I do have drivers/clk/vexpress (can
> be versatile, I don't really mind) directory in my local repo. This will
> happen in time for the next merge window.
>

I'd rather not take any more patches this close to the 3.6 merge
window.  How do you feel about holding onto this patch and
implementing some of the longer term changes mentioned by Linus
towards 3.7?

Regards,
Mike

> Cheers!
>
> Pawel
>
>
