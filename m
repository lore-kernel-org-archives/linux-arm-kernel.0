From: dvyukov@google.com (Dmitry Vyukov)
Date: Mon, 25 Jan 2016 14:03:55 +0100
Subject: [PATCH v6] kernel: add kcov code coverage
In-Reply-To: <1453726850-49137-1-git-send-email-dvyukov@google.com>
References: <1453726850-49137-1-git-send-email-dvyukov@google.com>
Message-ID: <CACT4Y+a_Tvi643CUVey=1_i4R+vV=_ZSrsP92AMRjcEo1V-dKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 2:00 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> kcov provides code coverage collection for coverage-guided fuzzing
> (randomized testing). Coverage-guided fuzzing is a testing technique
> that uses coverage feedback to determine new interesting inputs to a
> system. A notable user-space example is AFL
> (http://lcamtuf.coredump.cx/afl/). However, this technique is not
> widely used for kernel testing due to missing compiler and kernel
> support.

Kirill, I export kcov file as 0600 now.

Any more comments?

Andrew, will you take this to mm? Or how does it happen?
