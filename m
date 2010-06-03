From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Thu, 3 Jun 2010 17:59:10 +0300
Subject: [PATCH v3 00/14] omap: mailbox: bunch of cleanups
In-Reply-To: <20100603114726.GC7127@n2100.arm.linux.org.uk>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<20100603.094022.200375421.Hiroshi.DOYU@nokia.com>
	<20100603114726.GC7127@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinBMdcxzF_pZuiFHc1Eox_bYtD8PXG1OuKo0XWu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 3, 2010 at 2:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jun 03, 2010 at 09:40:22AM +0300, Hiroshi DOYU wrote:
>> > Felipe Contreras (14):
>> > ? omap: mailbox: trivial whitespace cleanups
>> > ? omap: mailbox: trivial cleanups
>
> I think folk need to read this:
>
> ? ? ? ?http://lkml.org/lkml/2010/6/2/472
>
> and consider what it means for the future, and what can be done to reduce
> the amount of "churn".

If I have to decipher that rant, my best guess is that he is
complaining about the amount of code. If that's the case, this patch
series is only doing good:
6 files changed, 168 insertions(+), 230 deletions(-)

Another part of the rant is the fact that Linus cannot follow the huge
amount of changes. I think "trivial whitespace cleanups" pretty much
says: don't look at me if you want to be productive, while "trivial
cleanups" says, look at me if you feel like looking at easy changes.
If I were to squash these two, I think the patch series would become
harder to follow.

Something that helps in other projects, like git, is that merges are
clearly identified.

Merge branch 'linux-arm'
 Merge branch 'linux-omap'
  Merge branch 'linux-omap-mbox'
   Merge branch 'fc-cleanups'
   Merge branch 'ob-kfifo'

Then it's a bit clearer what each patch series is doing in the mailbox
tree without looking at individual patches.

Cheers.

-- 
Felipe Contreras
