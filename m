From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Oct 2013 21:05:52 -0700
Subject: [PATCH 0/2] Versatile Express config update for 3.13
In-Reply-To: <1381930594-1701-1-git-send-email-pawel.moll@arm.com>
References: <1381930594-1701-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20131028040552.GA22890@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 02:36:32PM +0100, Pawel Moll wrote:
> Greetings,
> 
> This micro-series updates the Versatile Express defconfig in two stages:
> 
> 1. Makes the defconfig-ed kernels actually work on real boards and QEMU.
> 2. Enables all platform-specific drivers and features.
> 
> The first patch definitely should go in, as it is a de-facto bug fix.
> The second has been suggested to increase build coverage.
> 
> I've tried to keep the changes to minimum. The patches can be also
> pulled as described below.
> 
> Cheers!
> 
> Pawel
> 
> 
> The following changes since commit 61e6cfa80de5760bbe406f4e815b7739205754d2:
> 
>   Linux 3.12-rc5 (2013-10-13 15:41:28 -0700)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/pawelmoll/linux.git tags/vexpress/defconfig-for-v3.13

Based on the comments on at least the first patch I'm guessing you'll want to
respin, so I'll wait for a new pull request.


-Olof
