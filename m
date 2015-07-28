From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Tue, 28 Jul 2015 11:02:16 +0200 (CEST)
Subject: [linux-sunxi] [RFC] ARM: dts: sunxi: Add regulators and
 board-specific operating points for LeMaker BananaPi
In-Reply-To: <CAGb2v65ApKvrj6K+kw43u=0q6=auTsmQjCXhibgZkW+vd5nDqA@mail.gmail.com>
References: <1437960486-2809-1-git-send-email-public_timo.s@silentcreek.de>
 <55B5E6DB.8020009@redhat.com>
 <20150727123653.36C046C8007E@dd34104.kasserver.com>
 <55B62A1B.6030601@redhat.com><CAGb2v65ApKvrj6K+kw43u=0q6=auTsmQjCXhibgZkW+vd5nDqA@mail.gmail.com>
Message-ID: <20150728090216.892076C80D94@dd34104.kasserver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Chen-Yu Tsai schrieb am 27.07.2015 15:14:
>> ChenYu (in the CC), since you did most of the original work here, do
>> you know why we have an op at 0.9 volt, but none of our boards allow the
>> voltage to go that low in the regulator settings ?
> 
> I'm on vacation now, so apologies for the bad formatting.
> 
> The OPPs are from a common subset
> of the settings from the fex files available
> at the time. Some fex files actually set
> min and max voltage thus eliminating
> the highest and lowest OPPs.
> 
> At least that is how Maxime and I
> interpreted them.

IMHO for a common maximum opp that's a good approach. But for the lowest
frequency setting, it would seem more logical to me, to raise the voltage
to a point where all boards will run fine with them, unless those boards 
cannot handle the frequency regardless of the higher voltage.

Regards,

Timo
