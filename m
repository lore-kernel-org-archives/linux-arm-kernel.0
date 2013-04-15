From: olof@lixom.net (Olof Johansson)
Date: Sun, 14 Apr 2013 21:01:44 -0700
Subject: [GIT PULL] msm cleanup for 3.10
In-Reply-To: <8ya7gk7qsnp.fsf@huya.qualcomm.com>
References: <8ya7gk7qsnp.fsf@huya.qualcomm.com>
Message-ID: <20130415040144.GE10949@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 03:40:42PM -0700, David Brown wrote:
> The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:
> 
>   Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-cleanup-3.10

Hi,

I've pulled in all 4 branches, see two comments on the individual pull requests
though.

Given the date stamps on the commits, it seems like you've been sitting on
these for a while. Please try to send them in sooner in future release
cycles, it is perfectly OK to send a newer pull request for the same
branch with a few more patches on it later on (ideally with a new tag
describing the new portions). That way we don't get all the code so
late, and you run a lower risk of us being grumpy because several other
maintainers have also been late and we're slammed with merges.

The bulk of the material for the merge window really should be in arm-soc
by -rc6, with minor updates thereafter.


-Olof
