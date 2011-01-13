From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 13 Jan 2011 11:48:05 +0100
Subject: [PATCH] unbreak ehci-mxc on otg port of i.MX27
In-Reply-To: <1294909575-32709-1-git-send-email-eric@eukrea.com> ("Eric
	=?utf-8?Q?B=C3=A9nard=22's?= message of "Thu,
	13 Jan 2011 10:06:15 +0100")
References: <1294909575-32709-1-git-send-email-eric@eukrea.com>
Message-ID: <87tyhd13mi.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric B?nard <eric@eukrea.com> writes:

> commit 711669e5b80b6f2d88f61ed8a9681f83d8cbd201 fixed port 0 support
> for i.MX51 but broke it for (at least) i.MX27 which doesn't have
> a usb_phy1 clock but has a pdev->id 0.

ouch. Sorry for this. I didn't thought that imx51 was an exception
rather than the rule. Also, I think that imx53 may deserve same
treatment but I've neither a  imx53 nor its datasheet at hand to check
that.

thanks,
Arnaud
