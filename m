From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 28 Jan 2015 08:18:40 +0100
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <alpine.LFD.2.11.1501272027390.1322@knanqh.ubzr>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <20150127132127.GA869@amd>
 <CAL_JsqKM+2PtX_EpWXyOQHVXwf=jqVj8SroUGPO1Y2=Zj8_kMg@mail.gmail.com>
 <201501271532.25540@pali>
 <20150127174818.GM26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501271446330.1322@knanqh.ubzr>
 <20150127210943.GN26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501271614280.1322@knanqh.ubzr>
 <20150127223331.GP26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501272027390.1322@knanqh.ubzr>
Message-ID: <20150128071840.GA29927@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> In other words, what prevents someone from creating, say, a custom 
> minimal Barebox version that sits on top of the existing N900 
> bootloader?  Wouldn't that provide a much better user experience?

Lot of useless work, that would make user experience worse?

We have mostly working u-boot on N900. Its there, useful for boot
menus, but makes debugging tricky, so we want to keep working with
internal bootloader, too. And I have already explained this to you
before.

Now, would you stop assigning work to other people?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
