From: cooloney@gmail.com (Bryan Wu)
Date: Mon, 6 May 2013 13:40:37 -0700
Subject: Fwd: Tegra 30 System hangs because of commit "pinctrl: move
 subsystem mutex to pinctrl_dev struct"
In-Reply-To: <51880F2F.8010102@wwwdotorg.org>
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
 <51880F2F.8010102@wwwdotorg.org>
Message-ID: <CAK5ve-Lu_mrXDHvxv64GvzrxFYGW+2P2+_tOGGFKC9mf0FOpJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 6, 2013 at 1:14 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/06/2013 01:54 PM, Russell King - ARM Linux wrote:
>> On Mon, May 06, 2013 at 09:41:22PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> On 21:29 Mon 06 May     , Linus Walleij wrote:
>>>> On Sun, May 5, 2013 at 10:22 PM, Jean-Christophe PLAGNIOL-VILLARD
>>>> <plagnioj@jcrosoft.com> wrote:
>>>>
>>>>> I was thinking to put a jenkins to test Linus HEAD all the time
>>>>> And with some automatic test one some hw
>>>>>
>>>>> to detect it more quick
> ...
>> My conclusion is that build and boot test systems just don't work in an
>> open source environment as no one actively checks the results.  Why would
>> they - maintainers already have enough to do with reading 6500+ emails a
>> month on mailing lists.  Why bother going to look at a website as well
>> which might give even more work.
>
> Couldn't such a system email people pro-actively, so nobody had to do
> any manual checking? The kisskb(?) build system does that, as does the
> "zero day build system" thing from Intel, and I find them quite useful.
> Personally, I do the build/test checks manually myself, so if an
> automated system were to do it, it'd save me work rather than give me
> more work.

Yes, this 0day build system rocks. It will pull in specific branches
in maintainer branch and do building/automatic code checking like
smack/boot testing. If they find any issues, they will send out emails
directly to the authors and SoB persons. We just need to add our ARM
into to their system for such building/booting test.

So for this issue, it should be very easy to find and email to the author.

Thanks,
-Bryan
