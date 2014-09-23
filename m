From: olof@lixom.net (Olof Johansson)
Date: Mon, 22 Sep 2014 21:53:52 -0700
Subject: [GIT PULL] ARM: Keystone fixes for 3.17-rc4
In-Reply-To: <1410472179-12796-1-git-send-email-santosh.shilimkar@ti.com>
References: <1410472179-12796-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140923045352.GC7487@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 05:49:39PM -0400, Santosh Shilimkar wrote:
> The following changes since commit 2ce7598c9a453e0acd0e07be7be3f5eb39608ebd:
> 
>   Linux 3.17-rc4 (2014-09-07 16:09:43 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/fixes-v3.17-rc4
> 
> for you to fetch changes up to 99897500e54560397054aa238c771fa8284d0eb2:
> 
>   ARM: keystone: dts: fix bindings for pcie and usb clock nodes (2014-09-11 17:41:25 -0400)
> 

Merged, thanks -- but the patch is mislabelled. It's fixing a DT specification, not a binding.


-Olof
