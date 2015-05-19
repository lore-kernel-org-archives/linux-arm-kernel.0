From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 19 May 2015 23:32:14 +0200 (CEST)
Subject: [PATCH v7 08/13] ARM: unify MMU/!MMU addruart calls
In-Reply-To: <0103afd0e9dd50c1bf85153a38a3490f@agner.ch>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
 <2419398.cbLWQC7K5f@wuerfel> <b41ebeb9d62b9c49faec6500f73460b9@agner.ch>
 <5548280.7uBnLuun8k@wuerfel> <0103afd0e9dd50c1bf85153a38a3490f@agner.ch>
Message-ID: <alpine.DEB.2.11.1505192331220.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 May 2015, Stefan Agner wrote:
> Ok, I will rebase this patchset (06-13) then, send the clocksource patch
> (07) as a single patch and send the EFM32 convertion patch (10) together
> with a conversion patch of the other two platforms as a follow-up.

Is the clocksource one independent? Then I can just pick it up now and
route it through tip.

Thanks,

	tglx
