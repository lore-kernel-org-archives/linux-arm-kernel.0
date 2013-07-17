From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 17 Jul 2013 12:51:56 -0500
Subject: [PATCH RFC v2 0/14] Clean up debugging support
In-Reply-To: <20130717170406.GR24642@n2100.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
 <20130717170406.GR24642@n2100.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC4AB5F0@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 17, 2013 10:04 AM, Russell King wrote:
> On Tue, Jul 16, 2013 at 05:32:43PM +0100, Russell King - ARM Linux wrote:
>> This is the second posting of this series, with a few additional patches
>> on top to go a little further.  Changes since the last posting:
>
> Okay, I think everyone is happy with this, and it's time to go into
> linux-next, so it'll be visible in my tree from tomorrow.
>
> Please keep the tested-by/acked-by etc coming.

Russell,

I just posted a patch for ep93xx that removes its platform specific
options to select the low-level debug UART. If it looks ok you can
add it to your patch series.

Regards,
Hartley
