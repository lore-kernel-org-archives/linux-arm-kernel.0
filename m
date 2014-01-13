From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jan 2014 16:35:01 +0000
Subject: [PATCH v2 15/28] drm/i2c: tda998x: use the tda998x video
 format when cea mode
In-Reply-To: <20140113172220.521917ce@armhf>
References: <20140109120448.24d89eba@armhf>
 <20140111181832.GD15937@n2100.arm.linux.org.uk>
 <20140113170707.10b908dc@armhf>
 <20140113161333.GA15937@n2100.arm.linux.org.uk>
 <20140113172220.521917ce@armhf>
Message-ID: <20140113163501.GB15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 05:22:20PM +0100, Jean-Francois Moine wrote:
> On Mon, 13 Jan 2014 16:13:34 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > Sorry, I don't see what bearing your response to my reply has.
> 
> Simply that NXP people better like to use the cea mode.

Ah, I see.  It's a thread about your DRM driver, and about the lack of
audio on 1080 resolutions.  Taking it in context, the reported issue
appears to be lack of video when 1080p is selected, but the display
doesn't support 1080p.  That's hardly surprising.

Then rabeeh posts his message about lack of audio at 1920x1080.

Well, I can say that with the tda998x as it stands, the 1080* modes
work with audio with armada-drm, so there's no need to change this.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
