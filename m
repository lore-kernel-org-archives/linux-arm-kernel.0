From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 16:13:23 +0100
Subject: [PATCH v14 04/10] imx-drm: use defines for clock polarity settings
In-Reply-To: <1402913484-25910-4-git-send-email-denis@eukrea.com>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-4-git-send-email-denis@eukrea.com>
Message-ID: <20140624151323.GU32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 12:11:18PM +0200, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>

It would be nice to have a little more explanation in the commit messages
for these patches.  If you'd like to send me better commit messages for
these patches, I'll add them to what I already have:

	imx-drm: use defines for clock polarity settings

	imx-drm: add RGB666 support for parallel display.

It may also be worth describing the RGB666 format in the commit message
for:

	v4l2: add new V4L2_PIX_FMT_RGB666 pixel format.

And... getting some more acks for these patches would be very useful,
I think I'd like to see Sascha's ack for these... Sascha?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
