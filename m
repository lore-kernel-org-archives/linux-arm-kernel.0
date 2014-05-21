From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 May 2014 15:05:47 -0700
Subject: [GIT PULL 1/3] ARM: tegra: core code changes for 3.16
In-Reply-To: <1400264746-13106-1-git-send-email-swarren@wwwdotorg.org>
References: <1400264746-13106-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140521220547.GJ24972@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 12:25:44PM -0600, Stephen Warren wrote:
> This branch contains just a single patch this time around. Thierry
> enhanced Tegra's restart code to allow programming PMC scratch registers
> to request specific behaviour after reboot. One of the most useful
> options for mainline software is the ability to reboot directly into USB
> recovery mode, which e.g. allows the bootloader to be reflashed.
> 
> ----------------------------------------------------------------
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.16-soc
> 
> for you to fetch changes up to 498bb3da7e04ed82d9b66106c4baeb3000a7100e:
> 
>   ARM: tegra: Support reboot modes

Merged into next/soc. Thanks.


-Olof
