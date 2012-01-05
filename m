From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 5 Jan 2012 14:02:53 +0100
Subject: [PATCH v4] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <4F059BCB.9050504@bluegiga.com>
References: <1325766081-27864-1-git-send-email-lauri.hintsala@bluegiga.com>
 <4F059BCB.9050504@bluegiga.com>
Message-ID: <20120105130253.GA2562@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Shawn: Should we temporary add following lines into headers? Any
> better suggestions?

Why can't we simply use HW_DIGCTL_CHIPID? This register is at 0x8001c310
for both, MX23 and MX28.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120105/ba497e9b/attachment.sig>
