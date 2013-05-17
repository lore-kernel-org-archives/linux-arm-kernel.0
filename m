From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 17 May 2013 09:00:08 +0100
Subject: ux500 breaking multi-platform kernels
In-Reply-To: <CACRpkdbJosO7Ea8=BUdgVSf5fZwddWZb79ONaz3r+DqseAaF7Q@mail.gmail.com>
References: <CAL_JsqJzf8Aj6+K_qEYo3JbAoeJn36EerBfaGYT9EQj-zPaHUw@mail.gmail.com>
 <CACRpkdbJosO7Ea8=BUdgVSf5fZwddWZb79ONaz3r+DqseAaF7Q@mail.gmail.com>
Message-ID: <20130517080008.GJ3269@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 May 2013, Linus Walleij wrote:

> On Wed, May 15, 2013 at 10:30 PM, Rob Herring <robherring2@gmail.com> wrote:
> 
> > There are some initcalls on ux500 that are not properly
> > conditionalized.
> 
> Oh wow you actually compiled it in and tried to boot it on something
> else :-D
> 
> Highbank I suppose?
> 
> > The first is in ux500_l2x0_init and here is a fix:
> 
> I guess this is all -rc material. Can you send a proper patch (set)?

Feel free to add my fix for cpuidle to this set if it works for you.

If it doesn't I'll re-work.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
