From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 5 Aug 2015 20:11:38 +0200
Subject: [PATCH 01/23] Documentation: dt: atmel-at91: add clocks to
 system timer, rstc and shdwc
In-Reply-To: <1438335599-3301-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438335599-3301-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150805181137.GB11315@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 31, 2015 at 11:39:37AM +0200, Alexandre Belloni wrote:
> The system timer (at91rm9200), the reset controller and the shutdown
> controller need an input clock. This is the slow clock and they will not
> function without it.
> 
> Also fix the shutdown controller example.

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150805/7c1a4099/attachment.sig>
