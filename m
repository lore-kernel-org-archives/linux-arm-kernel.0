From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 16 Jul 2015 18:16:58 +0200
Subject: drm/edid: sound/core: pcm_drm_eld.c compilation error in 4.2
Message-ID: <20150716181658.553e6da7@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The file sound/core/pcm_drm_eld.c which was added by the commit

	838d1631b766529213684f07dd71cdf2e92f0623
	ALSA: pcm: add DRM ELD helper

lacks the function drm_eld_sad() which was defined by Russell's patch

	http://article.gmane.org/gmane.linux.ports.arm.kernel/411574
	drm/edid: add function to help find SADs

This patch has not been applied.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
