From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 13 Jan 2011 20:48:17 +0300
Subject: [PATCH v2] unbreak ehci-mxc on otg port of i.MX27
In-Reply-To: <1294926797-19345-1-git-send-email-eric@eukrea.com>
References: <20110113091229.GE12078@pengutronix.de>
	<1294926797-19345-1-git-send-email-eric@eukrea.com>
Message-ID: <4D2F3AE1.6000505@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Eric B?nard wrote:

> commit 711669e5b80b6f2d88f61ed8a9681f83d8cbd201 fixed port 0 support

    Please also specify the commit summary in parens, as asked by Linus. I think 
I have already asked you to do so.

> for i.MX51 but broke it for (at least) i.MX27 which doesn't have
> a usb_phy1 clock but has a pdev->id 0.

> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

WBR, Sergei
