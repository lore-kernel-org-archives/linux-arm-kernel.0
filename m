From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 17 Oct 2012 19:35:10 +0200
Subject: [PATCH 3/9] uprobes: allow ignoring of probe hits
In-Reply-To: <CAH+eYFBHXAWTinnVO8vEnEhFDQLibwo+BtxYJJYdPcG9__n5OQ@mail.gmail.com>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-3-git-send-email-rabin@rab.in>
 <20121015165218.GA10239@redhat.com>
 <CAH+eYFBHXAWTinnVO8vEnEhFDQLibwo+BtxYJJYdPcG9__n5OQ@mail.gmail.com>
Message-ID: <20121017173510.GA11019@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16, Rabin Vincent wrote:
>
> 2012/10/15 Oleg Nesterov <oleg@redhat.com>:
> >
> > Not sure I understand why we shouldn't call handlers in this case,
> > but OK, I know nothing about arm.
>
> This old discussion about kprobes should be useful:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/045755.html

Thanks... Not sure I understand this discussion...

And, to clarify, I am not arguing. Just curious.

So, is this like cmov on x86? And this patch allows to not report if
the condition is not true? Or there are other issues on arm?

Oleg.
