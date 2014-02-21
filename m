From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Feb 2014 14:47:06 -0800
Subject: [GIT PULL] integrator base patches for v3.15
In-Reply-To: <CACRpkdYeaMqTNUTqBSg6vNa9=VucjpFFkx3diHJJNgZTg+iq1w@mail.gmail.com>
References: <CACRpkdYeaMqTNUTqBSg6vNa9=VucjpFFkx3diHJJNgZTg+iq1w@mail.gmail.com>
Message-ID: <20140221224706.GC13233@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 01:35:38PM +0100, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> this is a set of patches I have sent for review and failed to get
> ACKs from the proper subsystem maintainers after repeated
> pings. However I now need to have this rotated in linux-next
> as a base for multiplatform, so please pull it in, it is all ARM
> drivers anyway. Russell pointed out some things and these
> have been fixed and iterated in this series.
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit b28a960c42fcd9cfc987441fa6d1c1a471f0f9ed:
> 
>   Linux 3.14-rc2 (2014-02-09 18:15:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/integrator-for-v3.15-1
> 
> for you to fetch changes up to 29525484cd2524a31ee0924831ab43b46ea6ebe1:
> 
>   ARM: integrator: select GPIO block (2014-02-13 11:21:37 +0100)

These patches are a little all over the place -- some is new dt bindings, some
are driver cleanups, etc. I ended up merging it into next/drivers since that's
what the bulk of the changes were in this time.

So, pulled. Thanks.


-Olof
