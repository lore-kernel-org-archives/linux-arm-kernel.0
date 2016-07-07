From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Jul 2016 22:42:07 -0700
Subject: [GIT PULL 6/6] arm64: tegra: Changes for v4.8-rc1
In-Reply-To: <20160701145026.25760-6-thierry.reding@gmail.com>
References: <20160701145026.25760-1-thierry.reding@gmail.com>
 <20160701145026.25760-6-thierry.reding@gmail.com>
Message-ID: <20160707054207.GS32389@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 04:50:26PM +0200, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
Hi,

> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.8-arm64
> 
> for you to fetch changes up to a3ceccd756edc3fc7829f6fb66afa1cef413767b:
> 
>   arm64: Update default configuration (2016-07-01 16:22:24 +0200)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> arm64: tegra: Changes for v4.8-rc1
> 
> A slew of updates for Tegra210 support: PMIC and regulator additions,
> which in turn allow a bunch of features to be enabled. Some assemblies
> of the Jetson TX1 come with a DSI panel that is now supported. For all
> other assemblies, this set of changes enables the HDMI output. Jetson
> TX1 can now also make use of the XUSB controller, and provided that it
> is supported by the bootloader, the GPU can also be enabled.
> 
> PMIC and regulator support is also added for Smaug, which will allow a
> number of interesting feature additions in future releases.
> 
> Finally, a bunch of configuration options are enabled to support the
> features mentioned above.

Hi, again here we keep DT changes separate from defconfig and Kconfig, etc,
changes. Please respin.  Note that we keep arm64 and arm DT changes separate,
so send two branches for those.

I guess there's just one defconfig patch, so send it as a patch instead of
a branch if you prefer, either is fine with us.


-Olof
