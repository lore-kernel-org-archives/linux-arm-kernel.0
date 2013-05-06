From: cooloney@gmail.com (Bryan Wu)
Date: Mon, 6 May 2013 12:32:28 -0700
Subject: Fwd: Tegra 30 System hangs because of commit "pinctrl: move
 subsystem mutex to pinctrl_dev struct"
In-Reply-To: <CACRpkda2EG0O-pfZQ5kLFX=cwSmUSVBJkR7Xvye3ROs3tstv9w@mail.gmail.com>
References: <CAK5ve-KXdS8az=Gtja-mF=Z3_EeZVA7bLYSU0EE2mf5bHmSUKw@mail.gmail.com>
 <CAK5ve-KBDyvjNRVMcXgfnhYcajdcGsuAKaepzCBt+epiXoYvSw@mail.gmail.com>
 <517ED12B.8080502@wwwdotorg.org> <20130504133004.GC24282@game.jcrosoft.org>
 <CACRpkdbBVJtWrRO+J=pWjfLXTcVKX++x-eeJQXGeQn_WOURUNQ@mail.gmail.com>
 <20130505112819.GD24282@game.jcrosoft.org>
 <CACRpkdZdT8==cUtH4=Y3LC-eVu6ntO2ojFC4bSXNuxa4hMJ=ZA@mail.gmail.com>
 <20130505202236.GF24282@game.jcrosoft.org>
 <CACRpkda2EG0O-pfZQ5kLFX=cwSmUSVBJkR7Xvye3ROs3tstv9w@mail.gmail.com>
Message-ID: <CAK5ve-L3tz0QHw8Wf6y2oM0sQEBZ_QyMA6qf5TfYnTv2j_ENqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 6, 2013 at 12:29 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, May 5, 2013 at 10:22 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
>
>> I was thinking to put a jenkins to test Linus HEAD all the time
>> And with some automatic test one some hw
>>
>> to detect it more quick
>
> Hm yeah, I think I need a broader diversity of testsystems too ... I have this
> nice Chromebook so I thought if I could get a mainline kernel running on
> it I'd have a bigger coverage as well.
>

I think Stephen are working on bring up linux-next daily build and QA
testing on Tegra hardware. This should be quite helpful.

Thanks,
-Bryan
