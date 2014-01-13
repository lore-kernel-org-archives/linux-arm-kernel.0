From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 13 Jan 2014 18:24:55 +0100
Subject: [PATCH v2 15/28] drm/i2c: tda998x: use the tda998x video format
 when cea mode
In-Reply-To: <20140113163501.GB15937@n2100.arm.linux.org.uk>
References: <20140109120448.24d89eba@armhf>
 <20140111181832.GD15937@n2100.arm.linux.org.uk>
 <20140113170707.10b908dc@armhf>
 <20140113161333.GA15937@n2100.arm.linux.org.uk>
 <20140113172220.521917ce@armhf>
 <20140113163501.GB15937@n2100.arm.linux.org.uk>
Message-ID: <20140113182455.1f8c3f40@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jan 2014 16:35:01 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> Ah, I see.  It's a thread about your DRM driver, and about the lack of
> audio on 1080 resolutions.  Taking it in context, the reported issue
> appears to be lack of video when 1080p is selected, but the display
> doesn't support 1080p.  That's hardly surprising.
> 
> Then rabeeh posts his message about lack of audio at 1920x1080.
> 
> Well, I can say that with the tda998x as it stands, the 1080* modes
> work with audio with armada-drm, so there's no need to change this.

My DRM driver also has audio with and without the cea mode for all
resolutions. At the time of Rabeeh's message, I just had forgot to
switch the audio pins...

So, TDA998x CEA mode or not?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
