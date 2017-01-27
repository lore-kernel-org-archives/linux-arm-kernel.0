From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 27 Jan 2017 20:02:33 +0100
Subject: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
In-Reply-To: <74f6b75a-66b0-789f-658b-0e9f5cfed5a8@roeck-us.net>
References: <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd> <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
 <20170127110947.GA5335@amd>
 <74f6b75a-66b0-789f-658b-0e9f5cfed5a8@roeck-us.net>
Message-ID: <20170127190233.GA20571@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>That sounds like fun. Changing bq27200-0 to bq27200_0 is Forbidden by
> >>the ABI Police, but taking the entire device away is ok.
> >
> >Stop trying to break other people's systems. Thanks you.

> You still have not shown that it does. Actually, I am trying to _fix_
> other people's systems (those using libsensors).

No, I don't know that it does. Please avoid 1) calling me police and
2) claiming that taking away entire devices is okay (when it probably
is not).

And no, I don't know if anyone uses hwmon ABI on affected N900. [And
how many other devices are affected, '-' seems to be quite common
character in kernel names.] If I knew about concrete breakage, we'd
have very different discussion.

Well, so first things first. What about fixing libsensors to allow '-'
and '*' in the name?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/1950d963/attachment-0001.sig>
