From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 1 Oct 2018 17:53:34 -0700
Subject: [GIT PULL] Late arm64 fixes for 4.19
In-Reply-To: <20181001174600.GB14755@arm.com>
References: <20181001174600.GB14755@arm.com>
Message-ID: <20181002005334.GC29284@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2018 at 06:46:01PM +0100, Will Deacon wrote:
> Hi Greg,
> 
> Please pull these late arm64 fixes for 4.19. Details in the tag, but we've
> fixed a hugetlb livelock issue that was reported by Fujitsu as well as
> removing some useless flexibility in our KVM SET_ONE_REG ioctl().
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:
> 
>   Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

Now pulled, thanks.

greg k-h
