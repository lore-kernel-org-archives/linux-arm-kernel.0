From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 15:52:29 +0000
Subject: [GIT PULL v2] pxa: patches for v2.6.37-rc
In-Reply-To: <AANLkTin_LK7MtJiz7e417k4XCumOBq+dnTgLBCe8HYj1@mail.gmail.com>
References: <AANLkTin_LK7MtJiz7e417k4XCumOBq+dnTgLBCe8HYj1@mail.gmail.com>
Message-ID: <20110114155229.GF15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 08:37:13AM -0600, Eric Miao wrote:
> Didn't realize that some of the fixing patches are in my devel branch, sorry
> for the noise. Please pull again and let know if there's any issue.
> 
> The following changes since commit 581548db3b3c0f6e25b500329eb02e3c72e7acbe:
> 
>   Merge branch 'release' of
> git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6
> (2011-01-13 11:02:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Thanks.  I'll wait until just before sending the pull request as this
commit is based on something beyond 9e9bc973, which is what I'm using
internally as the basis for anything I'm doing (as that is the last
commit where the kernels I care about are buildable.)
