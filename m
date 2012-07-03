From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 3 Jul 2012 15:40:19 -0700
Subject: [GIT PULL] Integrator common clock
In-Reply-To: <CACRpkda5xQLr+fhnsWm4ONUCzJxtMMCLkS2ek9ufDPV-u7PsGg@mail.gmail.com>
References: <CACRpkdYj46c1dpBhassGn2DWOpcmHHUQcUGb6VZ-bVL8bc2PJw@mail.gmail.com>
 <20120620212046.GI4402@gmail.com>
 <CACRpkdaDUvfEV-7zTTyb+NbZ1WnN+iz+9QzDCVESeizCowOCsg@mail.gmail.com>
 <CACRpkdZGjMa8dBdc_wrTxHUxHUTwzQM9W55XyU+6VEBnXb8z5g@mail.gmail.com>
 <CACRpkda5xQLr+fhnsWm4ONUCzJxtMMCLkS2ek9ufDPV-u7PsGg@mail.gmail.com>
Message-ID: <CAJOA=zPHA8eODFUMdei+GpAXTk0nWRBPpvfk9ux-rmQQNnXy3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2012 at 12:29 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jun 22, 2012 at 11:58 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>
>> I saw that an older version of the patches is on the clk-next branch
>> in your git, if you're carrying these please take the latest, I created
>> a branch based off v3.5-rc2 (as I see you're using this) at your
>> convenience:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
>> for-mike
>
> This is still the case, please pull this version of the patches
> (the last that were posted to the mail list...) or tell me to resend
> them if that is better.
>

Hi Linus,

I have a second question on this series.  The menu option for
CLK_VERSATILE is exposed for everybody with these series.  Is that
necessary?  I'd prefer that folks 'select' it from platform Kconfig
instead of having it globally exposed.

Thanks,
Mike

> Nice to see the tree in -next!
> Linus Walleij
