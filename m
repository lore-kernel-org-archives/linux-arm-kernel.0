From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 10 Oct 2013 16:14:19 -0700
Subject: [PATCH stable] ARM: multi_v7_defconfig: enable ARM_ATAG_DTB_COMPAT
In-Reply-To: <1381168846-11076-1-git-send-email-khilman@linaro.org>
References: <1381168846-11076-1-git-send-email-khilman@linaro.org>
Message-ID: <20131010231419.GH4301@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 11:00:46AM -0700, Kevin Hilman wrote:
> From: Olof Johansson <olof@lixom.net>
> 
> Without this, legacy platforms that can boot with a multiplatform
> kernel but that need the DTB to be appended, won't have a way to pass
> firmware-set bootargs to the kernel.
> 
> This is needed to boot multi_v7_defconfig on snowball, for instance.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> Greg, This is in Linus' tree as commit a0396b9bd5a4a7baf598b60d2ca53c605c440a42
> but we neglected to flag this for stable even though it's needed for
> older kernels too.  Please cherry-pick into stable.  
> 
> Intended for v3.11.y.  Thanks.

Now applied, thanks.

greg k-h
