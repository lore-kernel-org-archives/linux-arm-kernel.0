From: hgkr.klein@gmail.com (Helmut Klein)
Date: Tue, 3 Nov 2015 19:59:12 +0100
Subject: wrong value in kirkwood-ts219.dtsi
Message-ID: <56390400.5070408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo,

the line "reg = <0x12000 0x100>;" in the section "poweroff at 12100" is not 
correct

The base address of uart1, which is connected to the pic controller is 
0x12100 and not 0x12000

kernel v4.3 runs perfectly on my qnap ts110. I setup a minimal kernel 
configuration.
Otherwise i use debian unstable.

thanks a lot for still supporting my hardware. qnap dropped it severals 
years ago.

regards
Helmut Klein
