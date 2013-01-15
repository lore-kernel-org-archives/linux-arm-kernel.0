From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 15 Jan 2013 20:22:43 +1300
Subject: rtc: vt8500: Fix year field in vt8500_rtc_set_time
Message-ID: <1358234563.6868.13.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alessandro,

This patch was sent out at the same time as two other RTC fixes for
vt8500 but this one seems to have stopped somewhere along the way while
the other two have been accepted.

The patch is showing in the RTC patch system along with the other two:
http://patchwork.ozlabs.org/patch/208756/


Greg,
How did the first two patches find their way to you - did you pick them
up off one of the lists?

patch 1 - rtc: vt8500: Fix handling of data passed in struct rtc_time
patch 2 - [fix-3.8] rtc: vt8500: Correct handling of CR_24H bitfield

Hope this is enough information to help you figure out what I'm talking
about :)


Regards
Tony P
