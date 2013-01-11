From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 11 Jan 2013 16:38:50 +0400
Subject: [PATCHv2] ARM: mxs: select USB_ARCH_HAS_EHCI
In-Reply-To: <1357830235-15661-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1357830235-15661-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <50F007DA.30401@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-01-2013 19:03, Maxime Ripard wrote:

> Commit 09f6ffde introduced a dependency on USB_EHCI_HCD for the chipidea

    Please also specify that commit's summary in parens (or however you like).

> USB host driver, that in turns depends on USB_ARCH_HAS_EHCI.

> If this symbol is not selected by the ARCH, we are not able to use the
> chipidea driver anymore.

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   drivers/usb/Kconfig |    1 +
>   1 file changed, 1 insertion(+)

    You should post USB patches to linux-usb at vger.kernel.org.

WBR, Sergei
