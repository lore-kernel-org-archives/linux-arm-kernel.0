From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 04 May 2010 13:48:18 +0400
Subject: [PATCH 2.6.34-rc6] mxc: gadget: Fix bitfield for calculating
	maximum	packet size
In-Reply-To: <1272915663-21562-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1272915663-21562-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <4BDFED62.3050800@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Dinh.Nguyen at freescale.com wrote:

> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
>
> The max packet length bit mask used for isochronous endpoints
> should be 0x7FF instead of 0x8FF. 0x8FF will actually clear
> higher-order bits in the max packet length field.
>
> This patch applies to 2.6.34-rc6.
>
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>

   You should send this to the linux-usb mailing list.

WBR, Sergei
