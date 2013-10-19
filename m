From: will.deacon@arm.com (Will Deacon)
Date: Sat, 19 Oct 2013 18:09:54 +0100
Subject: [PULL REQ] Big Endian initial patch series
In-Reply-To: <20131018205405.GA28835@codethink.co.uk>
References: <20131018205405.GA28835@codethink.co.uk>
Message-ID: <20131019170954.GC25076@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

A few nits here...

Firstly, I'd suggest using [GIT PULL] instead of [PULL REQ] in the subject.
Many people filter on the first, so you might get missed with the latter.

On Fri, Oct 18, 2013 at 09:54:05PM +0100, Ben Dooks wrote:
> This series has been well tested and it would be great to get this
> merged now. So here is the pull request:
> 
> The following changes since commit 8b5ede69d24db939f52b47effff2f6fe1e83e08b:
> 
>   powerpc/irq: Don't switch to irq stack from softirq stack (2013-10-07 14:19:39 -0700)

Secondly, I'd suggest basing against a specific tag in mainline if possible,
rather than a random commit. I think -rc3 matches rmk's current
devel-stable branch.

> are available in the git repository at:
> 
>   ssh://git at git.baserock.org/delta/linux baserock/bjdooks/312-rc4/be/core-v2

This is an ssh URL, so it can't be pulled without some form of
authentication! Use git:// instead for pull requests.

It's also good form to put your pull requests on separate branches from what
you have been using for development, to make it clear that it is stable.
Another method is to use a signed tag (although this seems more common with
arm-soc than others).

Do you think you could send another pull request please?

Cheers,

Will
