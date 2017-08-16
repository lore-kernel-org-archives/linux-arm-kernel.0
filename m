From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 21:46:30 +0200
Subject: [GIT PULL] tee: updates for v4.14
In-Reply-To: <20170804093153.GA16698@jax>
References: <20170804093153.GA16698@jax>
Message-ID: <CAK8P3a25yWdWzAQiYE7THikDoC0D2h_qOZSmdFtw1AANf+TcSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 4, 2017 at 11:32 AM, Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> Hi arm-soc maintainers,
>
> The following changes since commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973:
>
>   Linux 4.13-rc3 (2017-07-30 12:40:36 -0700)
>
> are available in the git repository at:
>
>   http://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-drv-for-4.14
>
> for you to fetch changes up to 39e6519a3f135b143dee4d4fb5ac0438e75454e2:
>
>   tee: optee: sync with new naming of interrupts (2017-08-04 10:30:27 +0200)
>
> ----------------------------------------------------------------
> Small fixes and enhancements for the TEE subsystem

Pulled into next/drivers. A little more text would have been helpful here, e.g.
explaining why none of the bugfixes are for 4.13 or whether the naming change
for the interrupts is a compatible or incompatible change.

I looked through the changes myself and they all seem fine though.

       Arnd
