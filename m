From: stefan@agner.ch (Stefan Agner)
Date: Tue, 19 May 2015 23:32:59 +0200
Subject: [PATCH v7 08/13] ARM: unify MMU/!MMU addruart calls
In-Reply-To: <alpine.DEB.2.11.1505192331220.4225@nanos>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
 <2419398.cbLWQC7K5f@wuerfel> <b41ebeb9d62b9c49faec6500f73460b9@agner.ch>
 <5548280.7uBnLuun8k@wuerfel> <0103afd0e9dd50c1bf85153a38a3490f@agner.ch>
 <alpine.DEB.2.11.1505192331220.4225@nanos>
Message-ID: <84257d3d23dbcc063b6f60e73970cc40@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-19 23:32, Thomas Gleixner wrote:
> On Tue, 19 May 2015, Stefan Agner wrote:
>> Ok, I will rebase this patchset (06-13) then, send the clocksource patch
>> (07) as a single patch and send the EFM32 convertion patch (10) together
>> with a conversion patch of the other two platforms as a follow-up.
> 
> Is the clocksource one independent? Then I can just pick it up now and
> route it through tip.

With the current Kconfig symbol setup, both should be selected by other
config symbols (CLKSRC_OF by ARM_SINGLE_ARMV7M and CLKSRC_MMIO by
ARCH_MXC).

Hence yes, this can go independently through tip.

--
Stefan
