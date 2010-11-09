From: agust@denx.de (Anatolij Gustschin)
Date: Tue, 9 Nov 2010 09:48:41 +0100
Subject: [PATCH 2/2] imx: fix USB build when USB gadget is selected
In-Reply-To: <00929d858b30cf10e8a9e6a9dffd27d36b1abda4.1289285160.git.baruch@tkos.co.il>
References: <6c16c084bfda41cd104613bed66bbad7b5433c6d.1289285160.git.baruch@tkos.co.il>
	<00929d858b30cf10e8a9e6a9dffd27d36b1abda4.1289285160.git.baruch@tkos.co.il>
Message-ID: <20101109094841.4979d434@wker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  9 Nov 2010 08:47:55 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> Commit 126512e3f274802ca65ebeca8660237f0361ad48 (USB: add platform glue driver
> for FSL USB DR controller) broke i.MX build by selecting USB_FSL_MPH_DR_OF.
> 
> Cc: Anatolij Gustschin <agust@denx.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/usb/gadget/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks. But another patch fixing this has already been posted
to the linux usb devel list:

http://thread.gmane.org/gmane.linux.kernel/1052648/focus=38156

Anatolij
