From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Aug 2013 23:14:44 +0800
Subject: [GIT PULL 2/5] ARM: imx: soc changes for 3.12
In-Reply-To: <CAGa+x84dqBvSsPicz_cCuWjK_XpZUd-zCYanW785eEkvrUVX_A@mail.gmail.com>
References: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
 <1376833688-24542-2-git-send-email-shawn.guo@linaro.org>
 <87li3tvnj8.fsf@linaro.org>
 <20130822144242.GI30533@S2101-09.ap.freescale.net>
 <CAGa+x84dqBvSsPicz_cCuWjK_XpZUd-zCYanW785eEkvrUVX_A@mail.gmail.com>
Message-ID: <20130822151441.GA594@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 07:59:34AM -0700, Kevin Hilman wrote:
> Yes, the conflict is trivial, but having seen several similar ones
> this merge window, it's getting kinda old.  Also, I'm not crazy about
> having Linus see several merge conflicts to the same area.  He'll see
> that arm-soc folks are not properly coordinating things with Russell
> and IMO that's something we need to fix in ARM land, not expose it to
> Linus.

Understood.

> 
> Also, in the future, if you're already aware of merge conflicts in
> -next in a branch you're submitting for a pull request, it would be
> *very* helpful to mention that in the pull request.

Okay, got it.

<snip>

> > [1] https://lkml.org/lkml/2013/6/3/22
> 
> Seems this is an unrelated conflict to the one I was seeing in Kconfig.debug

Sorry, gave the wrong link.  It should be:

http://article.gmane.org/gmane.linux.kernel.next/28290

Shawn
