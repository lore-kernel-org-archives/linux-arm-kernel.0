From: ian@slimlogic.co.uk (Ian Lartey)
Date: Fri, 08 Mar 2013 17:14:00 +0000
Subject: [PATCH v8 10/12] clk: Kconfig for Palmas clock driver
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F82E45A0E@DQHE02.ent.ti.com>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
 <1362662276-20792-10-git-send-email-ian@slimlogic.co.uk>
 <A874F61F95741C4A9BA573A70FE3998F82E45A0E@DQHE02.ent.ti.com>
Message-ID: <513A1C58.6020600@slimlogic.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/13 01:13, Kim, Milo wrote:
>>   drivers/clk/Kconfig        |    8 ++++++++
>>   drivers/clk/Makefile       |    1 +
>>   drivers/leds/leds-palmas.c |   19 ++++++-------------
>
> If this patch is for only clock module, then LED patch should be detached.

Yes indeed.
>
> [PATCH v8 10/12] clk: Kconfig for Palmas clock driver
> [PATCH v8 12/12] clk: add a clock driver for palmas
> It could be joined into one patch file.

Kind of safer to keep them separate:

[PATCH v8 10/12] clk: Kconfig for Palmas clock driver
can often cause a merge conflict if there are already
additional drivers/files in the clk directory

[PATCH v8 12/12] clk: add a clock driver for palmas
has more chance of being applied without any issues
(unless the person taking the patch already has
their own clk-palmas.c.


>
> Best Regards,
> Milo
>


Regards,

Ian

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
