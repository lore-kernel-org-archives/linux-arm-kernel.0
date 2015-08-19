From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Aug 2015 17:10:03 +0200
Subject: [PATCH 3/3] ARM: dts: sun6i: Columbus: Add i2c controller for
 communicating with the LCD
In-Reply-To: <1438960955-6551-3-git-send-email-hdegoede@redhat.com>
References: <1438960955-6551-1-git-send-email-hdegoede@redhat.com>
 <1438960955-6551-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150819151003.GG30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 05:22:35PM +0200, Hans de Goede wrote:
> The Colombus development kit uses an optional 2048x1536 edp panel using
> an anx9804 parallel lcd to edp convertor. The anx9804 chip is controlled
> via an i2c bus which is connected to 2 regular gpio pins.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Fixed the checkpatch warning (convertor vs converter) and queued,
thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150819/67817c7d/attachment.sig>
