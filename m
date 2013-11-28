From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Nov 2013 22:26:45 +0100
Subject: [PATCHv6 2/4] ARM: dts: Add Freescale FTM PWM node for VF610.
In-Reply-To: <1384220218-12716-3-git-send-email-Li.Xiubo@freescale.com>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-3-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131128212644.GD14689@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 09:36:56AM +0800, Xiubo Li wrote:
> This adds devicetree node for VF610, and there are 8 channels supported
> by default.

By default? From looking at the driver code it seemed that the device
always supports 8 channels.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/54be3901/attachment.sig>
