From: balbi@ti.com (Felipe Balbi)
Date: Mon, 29 Dec 2014 11:20:34 -0600
Subject: [PATCH] ARM: onfig: multi_v7: Update it for Keystone defconfig
In-Reply-To: <1419873207-3630-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1419873207-3630-1-git-send-email-santosh.shilimkar@oracle.com>
Message-ID: <20141229172034.GK29379@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

subject typo: s/onfig/config/

On Mon, Dec 29, 2014 at 09:13:27AM -0800, Santosh Shilimkar wrote:
> @@ -346,9 +354,13 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_HCD_STI=y
>  CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_STORAGE=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_DEBUG=y
> +CONFIG_USB_DWC3_VERBOSE=y

you don't really need DEBUG or VERBOSE to be enabled always.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141229/3cd96336/attachment.sig>
