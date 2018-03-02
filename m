From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 2 Mar 2018 10:10:26 +0100
Subject: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
In-Reply-To: <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
 <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
Message-ID: <20180302091025.GC30267@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Linux-Regression-ID: lr#4b650f

On Tue 2018-02-27 09:43:32, Linus Walleij wrote:
> On Tue, Feb 27, 2018 at 12:13 AM, Pavel Machek <pavel@ucw.cz> wrote:
> 
> > I did git bisect, and the winner seems to be:
> >
> > pavel at duo:/data/l/linux-n900$ git bisect bad
> > c85823390215e52d68d3826df92a447ed31e5c80 is the first bad commit
> > commit c85823390215e52d68d3826df92a447ed31e5c80
> > Author: Linus Walleij <linus.walleij@linaro.org>
> > Date:   Wed Dec 27 16:37:44 2017 +0100
> >
> >     gpio: of: Support SPI nonstandard GPIO properties
> 
> I have fixes queued for this, tried to send a pull request yesterday
> but it turns out the fixes need fixing... OK I'm onto it anyways.

Do you have any updates? Is there way to fix dts so that this does not
trigger on N900?

If this is taking longer to fix, should c85823390215 be reverted in
the meantime? It does not seem particulary important/urgent...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/736069e8/attachment.sig>
