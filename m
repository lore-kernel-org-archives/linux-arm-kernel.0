From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Aug 2015 07:52:22 +0100
Subject: [PATCH v5 4/6] drm: bridge/dw_hdmi-i2s-audio: add audio driver
In-Reply-To: <20150808153540.GL7557@n2100.arm.linux.org.uk>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
 <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
 <20150808153540.GL7557@n2100.arm.linux.org.uk>
Message-ID: <20150825065222.GG27431@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 08, 2015 at 04:35:41PM +0100, Russell King - ARM Linux wrote:
> On Sat, Jun 20, 2015 at 12:28:15AM +0800, Yakir Yang wrote:
> > Add ALSA based HDMI I2S audio driver for dw_hdmi. Sound card
> > driver could connect to this codec through the codec dai name
> > "dw-hdmi-i2s-audio".

> I'm applying this patch to my tree with some changes.  I haven't seen
> anyone ack it, nor review it any further.  I'm hoping someone can ack
> this patch with the following changes below - I'll be posting it as
> part of my dw-hdmi devel updates later today.

I'm pretty sure I deleted this patch unread because what shows up in my
inbox is:

->  197   C 08/08 Russell King -  (1.1K) ? ??>Re: [PATCH v5 4/6] drm: bridge/dw_

so there's no indication that it's anything to do with audio :(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150825/9c435d3b/attachment.sig>
