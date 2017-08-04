From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 Aug 2017 13:23:06 +0200
Subject: [GIT PULL] DaVinci fixes for v4.13
In-Reply-To: <6dc06dd1-0d7b-1988-d5c9-9cfafcf847f3@ti.com>
References: <6dc06dd1-0d7b-1988-d5c9-9cfafcf847f3@ti.com>
Message-ID: <CAK8P3a32iCexgo=ivt-dugSLDDS3WWOyVQ1duNy5tjojOGYPDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 1:23 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> The following changes since commit 520eccdfe187591a51ea9ab4c1a024ae4d0f68d9:
>
>   Linux 4.13-rc2 (2017-07-23 16:15:17 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.13
>
> for you to fetch changes up to 6ea57ad6b9526f8106d0bf410b41a7223462ff89:
>
>   ARM: dts: da850-lcdk: drop unused VPIF endpoints (2017-07-27 16:29:44 +0530)
>
> ----------------------------------------------------------------
> Drop unused VPIF endpoints from device-tree.
> They should be used only when an actual
> remote-endpoint is connected.

Pulled into fixes, thanks!

       Arnd
