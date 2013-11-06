From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 6 Nov 2013 15:19:23 +0100
Subject: [RFC 2/4] ARM: OMAP: rx51: Register audio device
In-Reply-To: <1382909086-10493-3-git-send-email-sre@debian.org>
References: <1382909086-10493-1-git-send-email-sre@debian.org>
 <1382909086-10493-3-git-send-email-sre@debian.org>
Message-ID: <20131106141922.GB15551@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> From: Pali Roh?r <pali.rohar@gmail.com>
> 
> This patch adds support for the audio chip to the legacy
> boardcode of the Nokia N900.

In 0/4, you said:

> For example non DT boot
> does not work, because I did not yet add pdata in boardcode.

So, perhaps we don't need this patch for now and can rely only do
audio on device-tree-enabled configurations?

Thanks,
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
