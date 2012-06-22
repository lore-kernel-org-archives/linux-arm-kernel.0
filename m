From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Jun 2012 23:58:21 +0200
Subject: [GIT PULL] Integrator common clock
In-Reply-To: <CACRpkdaDUvfEV-7zTTyb+NbZ1WnN+iz+9QzDCVESeizCowOCsg@mail.gmail.com>
References: <CACRpkdYj46c1dpBhassGn2DWOpcmHHUQcUGb6VZ-bVL8bc2PJw@mail.gmail.com>
 <20120620212046.GI4402@gmail.com>
 <CACRpkdaDUvfEV-7zTTyb+NbZ1WnN+iz+9QzDCVESeizCowOCsg@mail.gmail.com>
Message-ID: <CACRpkdZGjMa8dBdc_wrTxHUxHUTwzQM9W55XyU+6VEBnXb8z5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 8:23 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Jun 20, 2012 at 11:20 PM, Mike Turquette <mturquette@ti.com> wrote:
>> On 20120619-08:53, Linus Walleij wrote:
>>> Hi ARM SoC people,
>>>
>>> would you consider pulling in the support form common clk in the Integrator,
>>> unless Mike shouts at me? I think I have adressed all review comments.
>>
>> Any reason for this code to go through the arm-soc tree instead of
>> common clk tree?
>
> There was the Nomadik changes set changing a lot of stuff
> that will probably conflict with drivers/clk/Makefile. But that's no
> big deal. (Usually Stepgen R fixes these up in -next anyway).
>
> So if you want it in clk instead, feel free to pull it! (Just
> tell the ARM SoC people...)

I saw that an older version of the patches is on the clk-next branch
in your git, if you're carrying these please take the latest, I created
a branch based off v3.5-rc2 (as I see you're using this) at your
convenience:

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
for-mike

A bigger problem however, is that this branch is not in linux-next
so it doesn't get merge and build testing.

Are you submitting this to Mr Rothwell for testing RealSoonNow
or it it going up through ARM SoC or something?

Yours,
Linus Walleij
