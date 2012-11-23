From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Nov 2012 22:58:04 +0530
Subject: [PATCH 1/8] DMA: PL330: use prefix in reg names to build under x86
In-Reply-To: <20121123172337.GD24119@mail.gnudd.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
 <1353683310-23654-2-git-send-email-ciminaghi@gnudd.com>
 <CAOh2x=ncwZNQDKvFia_yrCmmDJ1Kkk+wP4fhcdeo_YtE97ridA@mail.gmail.com>
 <20121123172337.GD24119@mail.gnudd.com>
Message-ID: <CAKohpokUHv96wutU1ZLxxnndR3wfTr3kjh3UKREtuiVV-V8+EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 November 2012 22:53, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> I tried that, but the resulting patch does not apply:

It will not. Git doesn't support it.

> $ git checkout -b pl330_test next-20121115
> Switched to a new branch 'pl330_test'
>
> $ git format-patch --word-diff 5f1e3c5~..5f1e3c5

I never asked you to do this. I asked you to use git diff command, just to
verify what you have done is right or not? You can't send output of that
as a patch :)

And maybe post that as an part of non-commit log, so that others can
quickly review it. But because your patch is too big, it will make it a huge
patch.

It was just an trick i was sharing with everybody else.

> Did I do anything wrong (sorry, I'm not a git guru at all) ?

Neither am i :)

--
viresh
