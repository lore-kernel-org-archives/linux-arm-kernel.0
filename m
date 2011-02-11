From: julien.boibessot@free.fr (Julien Boibessot)
Date: Fri, 11 Feb 2011 14:43:32 +0100
Subject: [PATCH v2] i.MX51 iomux: Fixes MX51_PAD_UART2_TXD__UART2_TXD
	declaration
In-Reply-To: <20110211122505.GB1866@richard-laptop>
References: <1297420916-14505-1-git-send-email-julien.boibessot@free.fr>
	<20110211122505.GB1866@richard-laptop>
Message-ID: <4D553D04.8010206@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

Richard Zhao a ?crit :
> #define _MX51_PAD_USBH1_DATA2__UART2_TXD	IOMUX_PAD(0x690, 0x290, 1, 0x09ec, 5, 0)
>
> Will you change the above line too?
>   
yes, you're right, it needs too.

Julien
