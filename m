From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 23:03:15 +0100
Subject: [PATCH v3] ARM: ux500: select WATCHDOG and MUSB for ux500
In-Reply-To: <1363869113-19610-1-git-send-email-fabio.baltieri@linaro.org>
References: <1363864186-11514-1-git-send-email-fabio.baltieri@linaro.org>
 <1363869113-19610-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkda2G7E0T=NTde1RXA_98HLbu7iOL27_+L_vXUKFrcgJig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 1:31 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> Enable ux500 specific USB and watchdog drivers by default on
> u8500_defconfig.
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
>
> Hi again Linus,
>
> seems like this is being harder than I thought...  In v2 I had a
> duplicated CONFIG_AB8500_USB symbol that was giving a warning in make
> u8500_defconfig, this version fixes it.  Sorry about that, I'm trying to
> keep this patch minimal, but maybe it's time for a real update to the
> savedefconfig output.

OK this version is applied anyway ... I'll try to do a savedefconfig
update at some point.

Yours,
Linus Walleij
