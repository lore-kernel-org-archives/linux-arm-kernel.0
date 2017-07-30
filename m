From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 30 Jul 2017 21:24:03 +0300
Subject: [PATCH 4/6] drm/tinydrm: mipi-panel: refactor to use driver id
In-Reply-To: <1501355870-13960-5-git-send-email-david@lechnology.com>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <1501355870-13960-5-git-send-email-david@lechnology.com>
Message-ID: <CAHp75VcdGi=TkB_7fPHROYoKJFUPZPGi=HvUAHuAvgZy-1_Epw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM, David Lechner <david@lechnology.com> wrote:
> This refactors the mipi-panel module to use the driver id for panel-specific
> data. This is in preparation for adding additional panels.
>

Wouldn't be better to split glue driver from what looks like more
generic in the first place? Then you will not need to spread some
stuff
over generic files.

Are we going to disrupt genericy of the framework already with second driver?!

-- 
With Best Regards,
Andy Shevchenko
