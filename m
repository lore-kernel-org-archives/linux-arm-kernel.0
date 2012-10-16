From: rabin@rab.in (Rabin Vincent)
Date: Tue, 16 Oct 2012 22:11:50 +0200
Subject: [PATCH 3/9] uprobes: allow ignoring of probe hits
In-Reply-To: <20121015165218.GA10239@redhat.com>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-3-git-send-email-rabin@rab.in>
 <20121015165218.GA10239@redhat.com>
Message-ID: <CAH+eYFBHXAWTinnVO8vEnEhFDQLibwo+BtxYJJYdPcG9__n5OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/15 Oleg Nesterov <oleg@redhat.com>:
> On 10/14, Rabin Vincent wrote:
>> Allow arches to decided to ignore a probe hit.  ARM will use this to
>> only call handlers if the conditions to execute a conditionally executed
>> instruction are satisfied.
>
> Not sure I understand why we shouldn't call handlers in this case,
> but OK, I know nothing about arm.

This old discussion about kprobes should be useful:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/045755.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/046544.html

> This conflicts with other changes in
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/oleg/misc uprobes/core
>
> Could you re-diff?

OK, I will rebase them.
