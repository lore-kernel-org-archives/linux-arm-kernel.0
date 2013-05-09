From: fathi.boudra@linaro.org (Fathi Boudra)
Date: Thu, 9 May 2013 20:51:57 +0300
Subject: Fwd: Tegra 30 System hangs because of commit "pinctrl: move
 subsystem mutex to pinctrl_dev struct"
In-Reply-To: <CAOesGMiqrXSPdEtUzGCuAuhdE4K7FVe65zMM962XuOrO555hnQ@mail.gmail.com>
References: <CAK5ve-KXdS8az=Gtja-mF=Z3_EeZVA7bLYSU0EE2mf5bHmSUKw@mail.gmail.com>
 <CAK5ve-KBDyvjNRVMcXgfnhYcajdcGsuAKaepzCBt+epiXoYvSw@mail.gmail.com>
 <517ED12B.8080502@wwwdotorg.org>
 <20130504133004.GC24282@game.jcrosoft.org>
 <CACRpkdbBVJtWrRO+J=pWjfLXTcVKX++x-eeJQXGeQn_WOURUNQ@mail.gmail.com>
 <20130505112819.GD24282@game.jcrosoft.org>
 <CACRpkdZdT8==cUtH4=Y3LC-eVu6ntO2ojFC4bSXNuxa4hMJ=ZA@mail.gmail.com>
 <20130505202236.GF24282@game.jcrosoft.org>
 <CACRpkda2EG0O-pfZQ5kLFX=cwSmUSVBJkR7Xvye3ROs3tstv9w@mail.gmail.com>
 <20130506194122.GG24282@game.jcrosoft.org>
 <20130506195403.GJ18614@n2100.arm.linux.org.uk>
 <CACRpkdZtPhzLFicYYZF0SZfp4dMJars+Z-7hTUZQ1JjPExXW3A@mail.gmail.com>
 <CACxGe6uo60OwRd7buPX4382_vE48MLWJYyB_ka+iS2FfVCa8mw@mail.gmail.com>
 <CAOesGMiqrXSPdEtUzGCuAuhdE4K7FVe65zMM962XuOrO555hnQ@mail.gmail.com>
Message-ID: <CAGNsrLDw0_yX9nkLYDg0e8-551P7r43UxziTp1TXyyxdiKR5nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 May 2013 19:13, Olof Johansson <olof@lixom.net> wrote:
> On Thu, May 9, 2013 at 6:25 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Mon, May 6, 2013 at 9:12 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Mon, May 6, 2013 at 9:54 PM, Russell King - ARM Linux
> Yes, a builder is quite useful. Several of us do our own builds as well.
>
> When it comes to boot coverage, I'm not sure how successful a central
> approach would be. It's something where I think Linaro could
> contribute a lot for their member platforms, but I haven't seen much
> engagement there yet.

My previous post was lost. Sorry to repost..

We've got a jenkins instance doing daily builds on various trees and
boot testing on the few boards we've got in the lab:
https://ci.linaro.org/jenkins/view/kernel-ci/

But it hasn't attracted much interest so far... It's been here since a year.

> Beyond there, I'd say the expectation is that each maintainer should
> keep an eye on their own platforms. They _should_ try building and
> booting linux-next on their platforms, to catch regressions early. And
> definitely around now, I'd like to see people boot mainline on their
> platforms to make sure we haven't added any severe regressions in the
> 3.10 merge window, etc. Some people are really good at this, others
> less so.
>
> What's the old saying, you can lead a horse to water but you can't
> make him drink? You can build a boot test cluster but you can't make
> anyone pay attention to it. :(
>
> -Olof

Cheers,

Fathi
