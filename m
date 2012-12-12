From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Dec 2012 14:13:03 +0530
Subject: [PATCH V3 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <1355301621.31620.66.camel@smile>
References: <3100e691db3f94c22afd98b609a1568d7e70dfe7.1350360935.git.viresh.kumar@linaro.org>
 <169edae67b9a051ca7448e5b62c3cd2c5c1db470.1350360935.git.viresh.kumar@linaro.org>
 <201212102208.52347.arnd@arndb.de>
 <CAKohpo=FjZuMOC-wuNc3q_FXbk546ttCLr55GkW9AL0Tz-HoBA@mail.gmail.com>
 <1355301621.31620.66.camel@smile>
Message-ID: <CAKohpom2h4ZrO_vFVUDOA_KfDmA-PpG1aPDMnufbM9kcUhc_OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 December 2012 14:10, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Will we survive if the patch is in mainline? I mean how big the impact
> of it is?

It doesn't fail to do fulfill its purpose and even ALL DT stuff would work well.
Its just the matter of using the right API's, design and bindings :)
