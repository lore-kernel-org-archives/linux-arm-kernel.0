From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Oct 2015 12:12:48 +0100
Subject: Run armv7 32 bit userspace on aarch64
In-Reply-To: <5615A0E1.1050402@linaro.org>
References: <5615A0E1.1050402@linaro.org>
Message-ID: <20151008111248.GE16807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 03:46:57PM -0700, Shi, Yang wrote:
> I'm trying to run armv7 little endian userspace on qemu aarch64 with 4.1.x
> kernel. I was told by someone such usecase is valid and I have CONFIG_COMPAT
> enabled in my kernel.
> 
> But, I ran into the below error. It looks the userspace application is
> trying to write a readonly page. I got the similar failure on arm vfp with
> Linaro images (4.1 kernel) too.
> 
> Did anyone have tried it recently?

-rc4 seems to be working fine with Debian Jessie armhf on my Juno boards.

Do you have a good way of reproducing this with a mainline kernel?

Will
