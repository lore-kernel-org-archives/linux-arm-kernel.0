From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2018 15:06:25 +0200
Subject: [GIT PULL] Freescale arm64 device tree fixups for 4.17
In-Reply-To: <20180327082948.GG8857@dragon>
References: <20180327082948.GG8857@dragon>
Message-ID: <CAK8P3a3-Cs8XKcyLWuUSk3kDV8pxbFRvaiwba1dw5V82aG_Kkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 10:29 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> Hi,
>
> This is a fix-up for "[GIT PULL 5/6] Freescale arm64 device tree updates
> for 4.17" [1].  After the pull-request gets merged, we're pointed out by
> Rob that the "fix" to IFC memory controller DTC warnings is wrong.
> Let's start over again by reverting the patches first.  Sorry about the
> reverting.

No worries, reverting stuff occasionally is absolutely expected.
Pulled into next/dt now, thanks!

       Arnd
