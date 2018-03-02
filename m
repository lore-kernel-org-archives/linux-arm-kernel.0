From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 2 Mar 2018 13:14:42 +0100
Subject: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
In-Reply-To: <CACRpkda-VLsMVqYx3Y6+3JtLJERhmeJZF5g4Gd9ecvgR1Nnr0A@mail.gmail.com>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
 <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
 <20180302091025.GC30267@amd>
 <CACRpkda=deFSmk2iyrtde3Z-aj6rW9_jNfE3Ep4X=ejprGxRUw@mail.gmail.com>
 <20180302103127.GA2081@amd>
 <CACRpkda-VLsMVqYx3Y6+3JtLJERhmeJZF5g4Gd9ecvgR1Nnr0A@mail.gmail.com>
Message-ID: <20180302121442.GB28931@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> Ok, so this code looks pretty crazy to me: I tried removing the
> >> "of_find_spi_gpio" part, and audio started working.
> >
> > Hmm. Looks like audio is working w/o any changes, too. Not sure why
> > festival hung on me before.
> 
> Does it mean that mainline is working find for you or
> do we need to look deeper into the problem in the OF
> lookup?

It now works for me.

(But take a look at the patch I sent -- I believe you are still
overwriting return values in a bad way, and code is quite confusing).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/c97368ff/attachment-0001.sig>
