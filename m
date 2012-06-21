From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Jun 2012 08:23:27 +0200
Subject: [GIT PULL] Integrator common clock
In-Reply-To: <20120620212046.GI4402@gmail.com>
References: <CACRpkdYj46c1dpBhassGn2DWOpcmHHUQcUGb6VZ-bVL8bc2PJw@mail.gmail.com>
 <20120620212046.GI4402@gmail.com>
Message-ID: <CACRpkdaDUvfEV-7zTTyb+NbZ1WnN+iz+9QzDCVESeizCowOCsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 11:20 PM, Mike Turquette <mturquette@ti.com> wrote:
> On 20120619-08:53, Linus Walleij wrote:
>> Hi ARM SoC people,
>>
>> would you consider pulling in the support form common clk in the Integrator,
>> unless Mike shouts at me? I think I have adressed all review comments.
>
> Any reason for this code to go through the arm-soc tree instead of
> common clk tree?

There was the Nomadik changes set changing a lot of stuff
that will probably conflict with drivers/clk/Makefile. But that's no
big deal. (Usually Stepgen R fixes these up in -next anyway).

So if you want it in clk instead, feel free to pull it! (Just
tell the ARM SoC people...)

Yours,
Linus Walleij
