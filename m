From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 9 May 2013 14:25:18 +0100
Subject: Fwd: Tegra 30 System hangs because of commit "pinctrl: move
 subsystem mutex to pinctrl_dev struct"
In-Reply-To: <CACRpkdZtPhzLFicYYZF0SZfp4dMJars+Z-7hTUZQ1JjPExXW3A@mail.gmail.com>
References: <CAK5ve-KXdS8az=Gtja-mF=Z3_EeZVA7bLYSU0EE2mf5bHmSUKw@mail.gmail.com>
 <CAK5ve-KBDyvjNRVMcXgfnhYcajdcGsuAKaepzCBt+epiXoYvSw@mail.gmail.com>
 <517ED12B.8080502@wwwdotorg.org> <20130504133004.GC24282@game.jcrosoft.org>
 <CACRpkdbBVJtWrRO+J=pWjfLXTcVKX++x-eeJQXGeQn_WOURUNQ@mail.gmail.com>
 <20130505112819.GD24282@game.jcrosoft.org>
 <CACRpkdZdT8==cUtH4=Y3LC-eVu6ntO2ojFC4bSXNuxa4hMJ=ZA@mail.gmail.com>
 <20130505202236.GF24282@game.jcrosoft.org>
 <CACRpkda2EG0O-pfZQ5kLFX=cwSmUSVBJkR7Xvye3ROs3tstv9w@mail.gmail.com>
 <20130506194122.GG24282@game.jcrosoft.org>
 <20130506195403.GJ18614@n2100.arm.linux.org.uk>
 <CACRpkdZtPhzLFicYYZF0SZfp4dMJars+Z-7hTUZQ1JjPExXW3A@mail.gmail.com>
Message-ID: <CACxGe6uo60OwRd7buPX4382_vE48MLWJYyB_ka+iS2FfVCa8mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 6, 2013 at 9:12 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, May 6, 2013 at 9:54 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>
>> My conclusion is that build and boot test systems just don't work in an
>> open source environment as no one actively checks the results.  Why would
>> they - maintainers already have enough to do with reading 6500+ emails a
>> month on mailing lists.  Why bother going to look at a website as well
>> which might give even more work.
>
> Point taken. I was in a discussion some time back with Greg and some
> other people and we concluded that unless the system mails you when
> something breaks it won't make a difference. And it mustn't flood you,
> just be very precise.
>
> Actually the autobuilder at kernel.org helped me out but then stopped
> building my trees at some point, but that was nice and the same thing
> doing boots would be great.

+1 on what has already been stated on this thread; An autobuilder does
work if it emails you when something breaks without spamming you. I've
also found the 0day build tester actually effective. It has caught
things that I've missed and I immediately was able to go an fix.

g.
