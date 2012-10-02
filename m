From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 1 Oct 2012 19:26:26 -0700
Subject: [GIT PULL 0/12] ARM: soc: updates for 3.7, first batch
In-Reply-To: <CA+55aFwoDOdKv9wcqEPkE76+w2TCz+419qp94T3_70jK9dR3-A@mail.gmail.com>
References: <1349135827-24790-1-git-send-email-olof@lixom.net>
 <CA+55aFwoDOdKv9wcqEPkE76+w2TCz+419qp94T3_70jK9dR3-A@mail.gmail.com>
Message-ID: <CA+55aFzmm=y85k81kAfgiuBb=oaFxi0f83hFb32Y2tTHu1wozw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2012 at 7:22 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, I've merged them all. As usual, my end result is slightly
> different from yours, although the differences are pretty small.

Oh, one more thing: I suspect the OMAP_OCP2SCP config option should
depend on CONFIG_ARM or something. Just based on the name, I assume it
doesn't actually work on x86-64, but I see the question..

               Linus
