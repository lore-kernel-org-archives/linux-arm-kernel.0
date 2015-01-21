From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 22 Jan 2015 00:01:49 +0100
Subject: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20150121230148.GJ13715@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Sorry for the big delay.

On Thu, Nov 20, 2014 at 08:14:36PM +0000, Stefan Wahren wrote:
> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
> power subsystem. It's required to trigger the probing of the underlying
> drivers like on-chip regulators. Additionally the drivers supports
> the configuration of the DC-DC clock frequency to avoid possible
> interferences.

I would expect PLL to be board specific and part of DT. Why is it
specified as parameter?

Apart from that the driver/patch looks fine to me.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150122/672303ef/attachment.sig>
