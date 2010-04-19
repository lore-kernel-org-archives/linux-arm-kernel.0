From: timur.tabi@gmail.com (Timur Tabi)
Date: Mon, 19 Apr 2010 15:53:01 -0500
Subject: [RFC PATCH 10/10] mx5: Add MX53 EVK board support
In-Reply-To: <DE2504B3A515524BBE6934369EFDC0DA0937E409@az33exm20.fsl.freescale.net>
References: <1271446524-26450-11-git-send-email-r.herring@freescale.com>
	<k2med82fe3e1004191340j5ff359d1q7a3470084b2d3ad2@mail.gmail.com>
	<DE2504B3A515524BBE6934369EFDC0DA0937E409@az33exm20.fsl.freescale.net>
Message-ID: <r2jed82fe3e1004191353yc1173cdai71204b1aa38d89a6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 19, 2010 at 3:47 PM, Herring Robert-RA7055
<ra7055@freescale.com> wrote:

>> You forgot to run checkpatch.pl. ?C++ comments are not allowed.
>
> Yes I know. I'm only soliciting comments on the way I have structured adding MX53 to MX51 codebase.

Ok.

>> How about:
>>
>> #define mxc_init_imx_uart() do { } while (0)
>
> Just following existing code style in board-mx51_babbage.c.

I understand, but I believe the consensus for general kernel
development is to use "#define .. do while(0)" to represent a no-op
function.

-- 
Timur Tabi
Linux kernel developer at Freescale
