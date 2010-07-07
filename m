From: Colin.Tuckley@arm.com (Colin Tuckley)
Date: Wed, 7 Jul 2010 09:51:10 +0100
Subject: [PATCH 3/3] ARM: register character LCD for RealView EB
In-Reply-To: <1278429686-5109-1-git-send-email-triad@df.lth.se>
References: <1278429686-5109-1-git-send-email-triad@df.lth.se>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA42DA39B5222@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> kernel-bounces at lists.infradead.org] On Behalf Of Linus Walleij

> The remaining PB11MPCore, PB-A8 and PBX-A9 seem to be those boxen
> without any LCD fitted, so no point in adding the device on those,
> even though the driver logic appears to be in the circuitry for all
> of them.

Correct, these boards are normally fitted inside cases so the LCD is not useful.

Colin

--
Colin Tuckley - ARM Ltd.
110 Fulbourn Rd
Cambridge, CB1 9NJ
Tel: +44 1223 400536

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
