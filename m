From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2018 10:00:03 +0200
Subject: [GIT PULL] Allwinner drivers changes for 4.20
In-Reply-To: <20180929141858.zt3z5lsahbqdhy4z@flea>
References: <20180929141858.zt3z5lsahbqdhy4z@flea>
Message-ID: <CAK8P3a3CFfe0m2RTdoRww4erSeT97T8GUc-==Uo9xsQVu7bq_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 29, 2018 at 4:19 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:

>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-drivers-for-4.20
>
> for you to fetch changes up to 69a8c2452caae22008ee170d3ef66e97e9df391e:
>
>   dt-bindings: sunxi-sram: add binding for Allwinner H6 SRAM C (2018-09-12 22:40:26 +0800)
>
> ----------------------------------------------------------------
> Allwinner drivers changes for 4.20
>
> The H6 is now supported in our SRAM driver bindings, and we have a small
> Makefile change for the SRAM driver to build it without building the
> ARCH_SUNXI architecture, especially relevant for the COMPILE_TEST case.

Pulled into next/drivers, thanks!

     Arnd
