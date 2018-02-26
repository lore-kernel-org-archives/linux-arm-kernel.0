From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 26 Feb 2018 14:13:18 +0100
Subject: regression v4.16 on Nokia N900: sound does not work
In-Reply-To: <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
Message-ID: <20180226131318.GA14045@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> JFYI: This issues is tracked in the regression reports for Linux 4.16
> (http://bit.ly/lnxregrep416 ) with this id:
> 
> Linux-Regression-ID: lr#4b650f

Ok, so it seems that issue is bigger: whole sound subsystem does not
work. /proc/asound/cards is empty.

7e6127c1240ed569cdda2a67c8f03836f9f28c05 seems to be bad already.

I tried to revert sound/soc changes, and sound is broken, too. Nasty
:-(.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/82bed8cf/attachment-0001.sig>
