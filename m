From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 22 Feb 2018 10:02:59 +0530
Subject: [PATCH] arm64: Fix compilation error while accessing
 MPIDR_HWID_BITMASK from .S files
In-Reply-To: <CAK8P3a2v9s8A8u+aRYgkQJL+TBmEauwuyFzPb_gnvU=1ZkntRA@mail.gmail.com>
References: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
 <CAK8P3a2v9s8A8u+aRYgkQJL+TBmEauwuyFzPb_gnvU=1ZkntRA@mail.gmail.com>
Message-ID: <CAOh2x=kyFCmvMTx=YwSv-bnQb6uiTzwHuJzNKigu6FyThEGxHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 4:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Note that when referencing a commit, it's best to abbreviate the commit
> ID to the first 12 characters like "e1a50de37860". You can also a line like
>
> Fixes: e1a50de37860 ("arm64: cputype: Silence Sparse warnings")
>
> which is the standard format to describe such regressions.

Right and this can be automated a bit as well. The procedure is
described in:

Documentation/process/submitting-patches.rst

You can update your .gitconfig file and then use the --pretty=<...>
argument to `git log` or `git show` commands.

--
viresh
