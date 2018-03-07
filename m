From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 16:08:48 +0100
Subject: [PATCH v2] ARM: socfpga: PM: Drop useless check for
 PM_SUSPEND_STANDBY
In-Reply-To: <1519999487-15474-1-git-send-email-geert+renesas@glider.be>
References: <1519999487-15474-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAK8P3a3Nc2OPxCqdD9p=UUy_min5y=eRD-yGa1zEKSOHPS2vRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2018 at 3:04 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> As SoCFPGA uses the standard suspend_valid_only_mem() for its
> platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
> callback will never be called with state equal to PM_SUSPEND_STANDBY.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>

Applied to next/soc, thanks!

       Arnd
