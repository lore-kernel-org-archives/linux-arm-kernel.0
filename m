From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Mon,  3 Aug 2015 00:00:06 +0200 (CEST)
Subject: [linux-sunxi] [RFC] ARM: dts: sunxi: Add regulators and
 board-specific operating points for LeMaker BananaPi
In-Reply-To: <55B79FCA.7070907@redhat.com>
References: <1437960486-2809-1-git-send-email-public_timo.s@silentcreek.de>
 <55B5E6DB.8020009@redhat.com>
 <20150727120918.191F76C82FB4@dd34104.kasserver.com>
 <55B62768.6040403@redhat.com>
 <20150728124911.GA2564@lukather><55B790BA.5000509@redhat.com>
 <20150728150929.233B56C80391@dd34104.kasserver.com><55B79FCA.7070907@redhat.com>
Message-ID: <20150802220006.E5BE06C810BC@dd34104.kasserver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

you didn't include me in your answer, hence the late reply...

Stefan Monnier schrieb am 29.07.2015 02:02:
>> IMHO for a common maximum opp that's a good approach. But for the lowest
>> frequency setting, it would seem more logical to me, to raise the voltage
>> to a point where all boards will run fine with them, unless those boards
>> cannot handle the frequency regardless of the higher voltage.

> I generally agre, tho IIRC some measurements seem to indicate that the
> lowest frequency settings did not bring much (if any) reduction in power
> consumption, making them rather useless.

That's an interesting point. However, that would be a different discussion. I
wouldn't mind if the 144MHz would be removed - my point was just that if it's 
supposed to be a common setting, it should work on all boards. I posted a patch
today to fix this. [1] That might be a good place to discuss whether this
setting should be removed entirely.

Regards,

Timo

[1] https://groups.google.com/forum/#!topic/linux-sunxi/fIfbdn7mrQA
