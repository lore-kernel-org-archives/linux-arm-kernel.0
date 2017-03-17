From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Mar 2017 20:03:47 +0000
Subject: [PATCH v21 00/13] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <CADyBb7urVf87LTsyrtoaAExTeOZSBAvT91enGBK4cm6723q+1Q@mail.gmail.com>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <CADyBb7t_zrLetPQQ8=k8oN6iMHhuMHO8O3XTZqGYvTT9p0evKw@mail.gmail.com>
 <CADyBb7urVf87LTsyrtoaAExTeOZSBAvT91enGBK4cm6723q+1Q@mail.gmail.com>
Message-ID: <20170317200346.GG15909@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 11:47:16PM +0100, Fu Wei wrote:
> Hi Mark, Marc,

Hi,

> I have tried to rebase all the 19(6+13) patches  on 4.11-rc1,
> all the patchse can directly apply on  4.11-rc1,
> 
> Could you help to review the patches, and see if there is anywhere I
> can improve ?

I'm sorry I have taken so long to review this posting.

This is generally looking much better. I'm not sure about a few details
relating to the watchdog, but I'm largely happy to pick up the rest of
the series, if you can address my comments.

Thanks,
Mark.
