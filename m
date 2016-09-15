From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 15 Sep 2016 22:51:42 +0200
Subject: v4.8-rc: GSM audio causes trouble
In-Reply-To: <20160915121755.GA5264@amd>
References: <20160915121755.GA5264@amd>
Message-ID: <20160915205142.GA6747@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> I was trying to improve GSM call quality, and hit problems in
> v4.8-rc. Sound only worked for a while, then I tried to kill
> cmtspeech_ofono_test, and could not, not even with -9 and could not
> even reboot.
> 
> I went back to v4.1 (ok, quite far, I see), and problems are gone.
> 
> Does it work for you? Any ideas what to try... besides bisect?

v4.7 is okay.

v4.8 with

git diff ..mini-v4.7 drivers/hsi/ | git apply

Seems to work ok.

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
