From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Jan 2017 21:00:58 +0530
Subject: [GIT PULL] DaVinci fix for v4.10
In-Reply-To: <214ce380-3c45-423c-a7bc-e19ea1ce2a2d@ti.com>
References: <214ce380-3c45-423c-a7bc-e19ea1ce2a2d@ti.com>
Message-ID: <74cda305-206b-1660-5567-32b2e7093d00@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 January 2017 04:23 PM, Sekhar Nori wrote:
> The following changes since commit 49def1853334396f948dcb4cedb9347abb318df5:
> 
>   Linux 4.10-rc4 (2017-01-15 16:21:59 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.10-part2
> 
> for you to fetch changes up to 6f042ee9cc09792c1c0f0cd8f275c2b4b29eaa96:
> 
>   ARM: dts: da850-evm: fix read access to SPI flash (2017-01-18 15:38:08 +0530)
> 
> ----------------------------------------------------------------
> This patch uses fast-read opcode to read the
> SPI flash. This is needed for error-free read
> at 30Mhz.

I should have pointed out here that I have tagged the patch for stable
kernel inclusion since this issue causes data corruption for the user.

Thanks,
Sekhar
