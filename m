From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 08 Nov 2014 18:26:27 +0100
Subject: [PATCH v1 0/3] Transition pxa25x clock to common clocks
In-Reply-To: <CALT56yOCBN1NAfNw=vThVZ_o=ONGOTvzKHBH5tCTQShJY0wkrQ@mail.gmail.com>
 (Dmitry Eremin-Solenikov's message of "Thu, 6 Nov 2014 12:45:02
 +0400")
References: <1414941415-13146-1-git-send-email-robert.jarzmik@free.fr>
 <CALT56yOCBN1NAfNw=vThVZ_o=ONGOTvzKHBH5tCTQShJY0wkrQ@mail.gmail.com>
Message-ID: <87lhnlwqm4.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Hello,
> Tested in qemu (pxa25x target).
>
> 2) sa1100-rtc could not find a clock and thus failed to be probed.
> 4) Got an issue with IrDA driver - it gets -ENODEV for UARTCLK clock

Hi Dmitry,

Would you mind retesting with the patch in [1] applied to see if points 2 and 4
are fixed ? Alternatively you can refetch from the github tree, I included that
incremental patch there too.

If it works correctly for you, could I have your Tested-by ? If not, tell me and
I'll try to figure out what's wrong.

Cheers.

-- 
Robert

[1]
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-fixup-clk-add-pxa25x-clock-drivers.patch
Type: text/x-diff
Size: 1467 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141108/e1c60818/attachment-0001.bin>
