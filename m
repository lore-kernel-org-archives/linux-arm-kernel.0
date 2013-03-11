From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 11 Mar 2013 13:02:59 +0800
Subject: [PATCH] ARM:kernel: beautify code, using 'static const' instead
 of 'const static'
In-Reply-To: <513D32E3.1080101@gmail.com>
References: <513BE8FA.6080304@asianux.com> <513D32E3.1080101@gmail.com>
Message-ID: <513D6583.8040506@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?03?11? 09:26, Rob Herring ??:
> On 03/09/2013 07:59 PM, Chen Gang wrote:
>> > 
>> >   better using 'static const' instead of 'const static'
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> > ---
>> >  arch/arm/kernel/smp_twd.c |    2 +-
>> >  1 files changed, 1 insertions(+), 1 deletions(-)
>> > 
>> > diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>> > index 3f25650..ef3e499 100644
>> > --- a/arch/arm/kernel/smp_twd.c
>> > +++ b/arch/arm/kernel/smp_twd.c
>> > @@ -362,7 +362,7 @@ int __init twd_local_timer_register(struct twd_local_timer *tlt)
>> >  }
>> >  
>> >  #ifdef CONFIG_OF
>> > -const static struct of_device_id twd_of_match[] __initconst = {
>> > +static const struct of_device_id twd_of_match[] __initconst = {
> This will go away with conversion to use CLKSRC_OF.

  excuse me, I am not quite familiar with ARM, so I do not quite
understand what you said.

  could you describe it with more details ?
  and how about this patch ?
    a. do not need this patch.
    b. or this patch need improving.
    c. or this patch is ok, can be applied.

  thanks.

-- 
Chen Gang

Asianux Corporation
