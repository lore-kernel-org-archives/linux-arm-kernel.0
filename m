From: dirk.behme@gmail.com (Dirk Behme)
Date: Sat, 07 Feb 2015 08:16:08 +0100
Subject: coresignt etm/etb usage
In-Reply-To: <CAHrpEqR0kPAPCvuFK0XdP9RTojH85xoATt1esbfGTCSPkPu0Tw@mail.gmail.com>
References: <CAHrpEqR0kPAPCvuFK0XdP9RTojH85xoATt1esbfGTCSPkPu0Tw@mail.gmail.com>
Message-ID: <54D5BBB8.20905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.02.2015 22:56, Zhi Li wrote:
> mathieu:
>
> I try to enable etm/etb in our freescale platform.


About which Freescale platform are you talking?

I've tried using the patches for the Freescale i.MX6 some month ago. 
I've managed to get the nodes like below, too. But never managed to 
get the ETM tracing data into the ETB. Only with attached HW JTAG 
debugger trace data has been recorded. And I never figured out which 
additional configuration the HW JTAG is doing compared to the SW only 
solution.

Best regards

Dirk


> I have ported your patches into our tree.
> coresign node already created in /sys/devices.
>
> 30041000.funnel  31001000.interrupt-controller  platform       software
> 3007c000.etm     backlight.7                    regulators.10  system
> 3007d000.etm     breakpoint                     replicator.1   timer.0
> 30084000.etb     gpio-keys.9                    soc.2          virtual
> 30087000.tpiu    max7322-reset.8                soc0
>
>
> But my problem is how to test it.
> Do you have document to show how to use it?
>
>
> best regards
> Frank Li
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
