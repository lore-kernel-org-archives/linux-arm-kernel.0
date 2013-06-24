From: lho@apm.com (Loc Ho)
Date: Mon, 24 Jun 2013 13:41:32 -0700
Subject: [PATCH v3 1/3] clk: Add APM X-Gene SoC clock driver for
 reference, PLL, and device clocks.
In-Reply-To: <20130624195725.GA11289@e106331-lin.cambridge.arm.com>
References: <1372100487-9367-1-git-send-email-lho@apm.com>
 <1372100487-9367-2-git-send-email-lho@apm.com>
 <20130624195725.GA11289@e106331-lin.cambridge.arm.com>
Message-ID: <CAPw-ZTn4yf90Dj14FprdbpfFozQmjGTg5fTYD1d_CR3FctYd6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mar,

>> +       if (of_property_read_u32(np, "flags", &parameters.flags))
>> +               parameters.flags = 0;
>
> As mentioned previously, I believe you could use the standard status
> property instead of flags.
[Loc Ho]
Okay... As mentioned, this will enforce multiple DTS file or patching
the DTS entry for clock as well as the driver DTS entry.

-Loc
