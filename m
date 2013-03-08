From: ian@slimlogic.co.uk (Ian Lartey)
Date: Fri, 08 Mar 2013 17:13:09 +0000
Subject: [PATCH v8 11/12] leds: Kconfig for Palmas LEDs
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F82E45A15@DQHE02.ent.ti.com>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
 <1362662276-20792-11-git-send-email-ian@slimlogic.co.uk>
 <A874F61F95741C4A9BA573A70FE3998F82E45A15@DQHE02.ent.ti.com>
Message-ID: <513A1C25.7050204@slimlogic.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/13 01:13, Kim, Milo wrote:
>> Add the Kconfig and Makefile for the Palmas LED driver.
>
> It would be better if the Palmas LED driver files are combined into one patch.
> [PATCH v8 09/12] leds: Add support for Palmas LEDs
> [PATCH v8 11/12] leds: Kconfig for Palmas LEDs

[PATCH v8 11/12] leds: Kconfig for Palmas LEDs
can often cause a merge conflict if there are already
additional drivers/files in the leds directory

[PATCH v8 09/12] leds: Add support for Palmas LEDs
has more chance of being applied without any issues
(unless the person taking the patch already has
their own leds-palmas.c.

>
> Best Regards,
> Milo
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
