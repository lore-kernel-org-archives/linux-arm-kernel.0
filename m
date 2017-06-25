From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 25 Jun 2017 11:18:56 +0200
Subject: omap3isp camera was Re: [PATCH v1 0/6] Add support of OV9655 camera
In-Reply-To: <1E453955-0C1A-414B-BBB2-C64B6D0EF378@goldelico.com>
References: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
 <385A82AC-CC23-41BD-9F57-0232F713FED9@goldelico.com>
 <1E453955-0C1A-414B-BBB2-C64B6D0EF378@goldelico.com>
Message-ID: <20170625091856.GA22791@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> * unfortunately we still get no image :(
> 
> The latter is likely a setup issue of our camera interface (OMAP3 ISP = Image Signal Processor) which
> we were not yet able to solve. Oscilloscoping signals on the interface indicated that signals and
> sync are correct. But we do not know since mplayer only shows a green screen.

What mplayer command line do you use? How did you set up the pipeline
with media-ctl?

On kernel.org, I have tree called camera-fw5-6 , where camera works
for me on n900. On gitlab, there's modifed fcam-dev, which can be used
for testing.

Best regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170625/60b95330/attachment.sig>
