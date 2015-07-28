From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Tue, 28 Jul 2015 17:01:23 +0200 (CEST)
Subject: [linux-sunxi] [RFC] ARM: dts: sunxi: Add regulators and
 board-specific operating points for LeMaker BananaPi
In-Reply-To: <20150728125545.GC2564@lukather>
References: <1437960486-2809-1-git-send-email-public_timo.s@silentcreek.de>
 <55B5E6DB.8020009@redhat.com>
 <20150727123653.36C046C8007E@dd34104.kasserver.com>
 <55B62A1B.6030601@redhat.com>
 <CAGb2v65ApKvrj6K+kw43u=0q6=auTsmQjCXhibgZkW+vd5nDqA@mail.gmail.com>
 <20150728090216.892076C80D94@dd34104.kasserver.com><20150728125545.GC2564@lukather>
Message-ID: <20150728150123.1AAA46C86538@dd34104.kasserver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Maxime Ripard schrieb am 28.07.2015 14:55:
>> IMHO for a common maximum opp that's a good approach. But for the lowest
>> frequency setting, it would seem more logical to me, to raise the voltage
>> to a point where all boards will run fine with them, unless those boards 
>> cannot handle the frequency regardless of the higher voltage.
> 
> Agreed.

Ok, then I will write another patch for this as well, unless Chen-Yu or
someone else objects.

Regards,

Timo
