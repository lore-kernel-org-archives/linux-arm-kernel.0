From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 5 Feb 2014 07:41:50 +0100
Subject: [GIT PULL] tree-wide: clean up no longer required #include
 <linux/init.h>
In-Reply-To: <20140205172723.3fa841793b3fa3f3f534937f@canb.auug.org.au>
References: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
 <20140205060633.GE30094@gmail.com>
 <20140205172723.3fa841793b3fa3f3f534937f@canb.auug.org.au>
Message-ID: <20140205064150.GA31568@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Ingo,
> 
> On Wed, 5 Feb 2014 07:06:33 +0100 Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > So, if you meant Linus to pull it, you probably want to cite a real 
> > Git URI along the lines of:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
> 
> Paul provided the proper git url further down in the mail along with the
> usual pull request message (I guess he should have put that bit at the
> top).

Yeah, indeed, and it even comes with a signed tag, which is an extra 
nice touch:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux.git tags/init-cleanup

(I guess the https was mentioned first to lower expectations.)

Thanks,

	Ingo
