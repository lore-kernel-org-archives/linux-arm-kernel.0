From: ccross@android.com (Colin Cross)
Date: Wed, 18 Jul 2012 11:10:14 -0700
Subject: [PATCH] ARM: ftrace: Trace function entry before updating index
In-Reply-To: <1342633133.11900.13.camel@gandalf.stny.rr.com>
References: <1342490592-20373-1-git-send-email-ccross@android.com>
 <1342633133.11900.13.camel@gandalf.stny.rr.com>
Message-ID: <CAMbhsRToTJPJuXT-rhN0cYcp2d3YjcQYL7t=4n9fn+t77TuS+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 10:38 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 2012-07-16 at 19:03 -0700, Colin Cross wrote:
>> Commit 722b3c74695377d11d18a52f3da08114d37f3f37 modified x86 ftrace to
>> avoid tracing all functions called from irqs when function graph was
>> used with a filter.  Port the same fix to ARM.
>>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>
> Someone on the ARM side needs to pull this in.
>
> I'll look into fixing this for PPC.
>
> Thanks!

Thanks, I'll put it in Russell's patch tracker.
