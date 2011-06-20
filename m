From: PeterHuewe@gmx.de (Peter =?iso-8859-1?q?H=FCwe?=)
Date: Mon, 20 Jun 2011 21:46:15 +0200
Subject: [PATCH 2/2] mfd/ab8500: Use kstrtoul_from_user
In-Reply-To: <BANLkTikKRVP4PW48YtR+mMMNsaxTDxoGtw@mail.gmail.com>
References: <1307393012-32582-1-git-send-email-peterhuewe@gmx.de>
	<1307393012-32582-2-git-send-email-peterhuewe@gmx.de>
	<BANLkTikKRVP4PW48YtR+mMMNsaxTDxoGtw@mail.gmail.com>
Message-ID: <201106202146.16585.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag 20 Juni 2011, 15:45:46 schrieb Alexey Dobriyan:
> NAK
> You should use kstrtou8_from_user() and drop 0xff check as well.
> 
> Do NOT blindly replace strict_strtoul with kstrtoul.

Thanks for spotting this - I'll review my other patches as well and redo them.
Sorry for any inconvenience.

Thanks,
Peter
