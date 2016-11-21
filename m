From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Mon, 21 Nov 2016 11:18:00 +0800
Subject: [PATCH V8 1/3] tracing: add a possibility of exporting function
 trace to other places instead of ring buffer only
In-Reply-To: <20161118114523.70b9583f@gandalf.local.home>
References: <1479438454-28650-1-git-send-email-zhang.chunyan@linaro.org>
 <1479438454-28650-2-git-send-email-zhang.chunyan@linaro.org>
 <20161118092905.769044bf@gandalf.local.home>
 <87vavkesy6.fsf@ashishki-desk.ger.corp.intel.com>
 <20161118114523.70b9583f@gandalf.local.home>
Message-ID: <CAG2=9p_SUGt4GPNvegV78se_rVau1Pzn-=TyObH+SiO+ETtOiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2016 at 00:45, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 18 Nov 2016 16:57:53 +0200
> Alexander Shishkin <alexander.shishkin@linux.intel.com> wrote:
>
>> Steven Rostedt <rostedt@goodmis.org> writes:
>>
>> > This looks good to me, although I would like this to go through my tree
>> > (to make sure it gets all my testing). I understand the next two
>> > patches depend on this, how would you want to go about that?
>> >
>> > One is that I can pull it in the next merge window, and the rest go in
>> > after that. Or I can take the other two patches with the proper acks as
>> > well.
>>
>> I just asked for the last patch be split 4 ways, but otherwise, they
>> have my acks. If Chunyan can do that, you can take all of them into your
>> tree.
>>
>
> OK, I'll wait for the split then.

OK, I will split that and send another patch-set with Alex's acks.

Many thanks for the reviews from you two,
Chunyan

>
> Thanks,
>
> -- Steve
