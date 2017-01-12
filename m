From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 12 Jan 2017 19:18:26 +0100
Subject: Nokia N900: mixers changed between 4.6 and 4.10, no longer can use
 in-call speaker
Message-ID: <20170112181826.GA28290@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

In v4.10 (and probably v4.9, too) I can no longer use the in-call
speaker. I can no longer use the wired headset, either.

v4.4 (and probably v4.6) works ok.

Any ideas? Does wired headset / in-call speaker work for you?

"Mono" and "Mono DAC" options are still there.. but something else
changed, as alsamixer now shows way many more options (meaning they
are shorter?) and I get complains from alsactl:

alsactl: set_control:1328: failed to obtain info for control #49 (No
such file or directory)
...
alsactl: set_control:1328: failed to obtain info for control #229 (No
such file or directory)



								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170112/686d3a2c/attachment-0001.sig>
