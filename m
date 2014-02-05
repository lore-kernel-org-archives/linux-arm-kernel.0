From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 5 Feb 2014 07:06:33 +0100
Subject: [GIT PULL] tree-wide: clean up no longer required #include
 <linux/init.h>
In-Reply-To: <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
References: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
Message-ID: <20140205060633.GE30094@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> On Feb 4, 2014 3:52 PM, "Paul Gortmaker" <paul.gortmaker@windriver.com>
> wrote:
> >
> > We've had this in linux-next for 2+ weeks (thanks Stephen!) as a
> > linux-stable like queue of patches, and as can be seen here:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
> 
> Argh, above link is meant for cloning, not viewing.
> 
> This should be better...
> 
> https://git.kernel.org/cgit/linux/kernel/git/paulg/init.git/

So, if you meant Linus to pull it, you probably want to cite a real 
Git URI along the lines of:

   git://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git

( Otherwise your pull request might be ignored or worse, you might get
  an honest reply, due to the https transport being considered evil
  that no free man outside of corporate firewalls should ever consider
  and all that. )

Nice cleanups btw.

Thanks,

	Ingo
