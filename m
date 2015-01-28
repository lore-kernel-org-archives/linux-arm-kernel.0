From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 28 Jan 2015 09:25:36 +0100
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <F2E2E152-2054-4284-9DAC-67FEC30DF399@jcrosoft.com>
References: <201501271532.25540@pali>
 <20150127174818.GM26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501271446330.1322@knanqh.ubzr>
 <20150127210943.GN26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501271614280.1322@knanqh.ubzr>
 <20150127223331.GP26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501272027390.1322@knanqh.ubzr>
 <1FECE32B-0D63-4696-BED7-74FE5845C260@jcrosoft.com>
 <20150128071950.GB29927@amd>
 <F2E2E152-2054-4284-9DAC-67FEC30DF399@jcrosoft.com>
Message-ID: <20150128082536.GA2270@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2015-01-28 16:06:17, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > On Jan 28, 2015, at 3:19 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > 
> > Hi!
> > 
> >>> In other words, what prevents someone from creating, say, a custom 
> >>> minimal Barebox version that sits on top of the existing N900 
> >>> bootloader?  Wouldn't that provide a much better user experience?
> >> 
> >> I do agree with Nicolas
> >> 
> >> If I can get my hand on a phone I?ll put barebox on it
> > 
> > Grab it in the nearest "second hand cellphones" shop, and have fun! It
> > should be less than $70.
> 
> will see if I can found one in Shanghai at the second hand market
> 
> Does it exist a qemu emulation?

Yes, linaro-qemu supports it. (But people are trying to break it
"because it is not real hardware so it can be fixed").

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
