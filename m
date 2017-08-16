From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 21:51:20 +0200
Subject: [GIT PULL 1/5] ARM: s3c24xx: Early stuff for v4.14
In-Reply-To: <20170724190856.19055-1-krzk@kernel.org>
References: <20170724190856.19055-1-krzk@kernel.org>
Message-ID: <CAK8P3a1JEfJ95bmAnR6bLUtw9Eyt++4+SxPoNi_Pj5wVk2crCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 9:08 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.14
>
> for you to fetch changes up to f991ce429a420dbb42b3e4b5a47490c84390d7e1:
>
>   ARM: s3c24xx: make H1940BT depend on RFKILL (2017-07-20 20:26:24 +0200)
>
> ----------------------------------------------------------------
> Samsung mach/soc changes for v4.14
>
> Only for S3C24xx platform:
> 1. Cleanup from non-existent CONFIG entries.
> 2. Fix unmet NET dependency when H1940 bluetooth chip is selected..

Pulled into next/soc, thanks!

        Arnd
