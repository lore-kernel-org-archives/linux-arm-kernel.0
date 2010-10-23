From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Sat, 23 Oct 2010 10:08:30 +0200
Subject: [PATCHv6 2/3] ARM: mx5: Add gpio-keys to mx51 babbage board
In-Reply-To: <1287801976-5324-2-git-send-email-Dinh.Nguyen@freescale.com>
References: <1287801976-5324-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1287801976-5324-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <4CC297FE.1060305@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

Le 23/10/2010 04:46, Dinh.Nguyen at freescale.com a ?crit :
> @@ -281,6 +299,7 @@ __setup("otg_mode=", babbage_otg_mode);
>   static void __init mxc_board_init(void)
>   {
>   	struct pad_desc usbh1stp = MX51_PAD_USBH1_STP__USBH1_STP;
> +	struct pad_desc power_key = MX51_PAD_EIM_A27__GPIO_2_21
>
here, this line leads to a compile error because of a missing ';' at the end.

Eric
