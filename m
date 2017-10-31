From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 31 Oct 2017 12:17:10 +0100
Subject: CONFIG_ARCH_SUPPORTS_INT128 for AArch64
In-Reply-To: <20171031104332.gqpd6icvrxt2uj4c@lakrids.cambridge.arm.com>
References: <CAHmME9q3=k2fJMi4Zy6d=ewj-P=sRhB8c_MjSJAMbKkopThi1w@mail.gmail.com>
 <20171031104332.gqpd6icvrxt2uj4c@lakrids.cambridge.arm.com>
Message-ID: <CAHmME9pE+G0V-nyKchQyG03YXbPjGykL1xX0M8E544Rh7QrgOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Oct 31, 2017 at 11:43 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Judging by Documentation/kbuild/makefiles.txt, we could do something
> like the below in the arm64 Makefile:
>
> cflags-y += $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)

Okay, in that case, I'll re-research the gcc commit that made int128
work properly on aarch64, confirm the release version, and then submit
a patch doing this.

Jason
