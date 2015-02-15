From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 15 Feb 2015 17:20:29 +0100
Subject: n900 audio: any ideas how to get headset speaker to work?
In-Reply-To: <201502151208.03126@pali>
References: <20150215102152.GA23736@amd>
 <201502151208.03126@pali>
Message-ID: <20150215162028.GA6857@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2015-02-15 12:08:02, Pali Roh?r wrote:
> On Sunday 15 February 2015 11:21:52 Pavel Machek wrote:
> > Hi!
> > 
> > By default, output goes to loudspeaker (top right relative to
> > keyboard). Any ideas how to switch it to the speaker on the
> > left or wired headset? Because I suspect that echo
> > cancelation is not going to be simple...
> > 									Pavel
> 
> I do not know but maybe this file could help:
> 
> https://gitorious.org/community-ssu/policy-settings-rx51/source/dcb6429c12006dc9850cc942b7143358fe3fd330:rx51/etc/alsaped.conf
> 
> There are definitions of alsa channels and settings for different profiles.

Thanks... it seems to be what I needed. More code to write...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
