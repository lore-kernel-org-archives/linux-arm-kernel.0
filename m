From: koen@dominion.thruhere.net (Koen Kooi)
Date: Wed, 13 Aug 2014 14:58:09 +0200
Subject: [linux-sunxi] simplefb: add clock handling
In-Reply-To: <jwvsil0r3gc.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <CANq1E4Re79+D5H-pf8pW87NZ5MWz9UFknd5Dk2GKCvhzm5MNSA@mail.gmail.com>
 <BFCF4C2C-77ED-4719-903B-921DEB250B7A@dominion.thruhere.net>
 <53EB238B.5010404@redhat.com>
 <958E7D39-A034-42AC-A6FF-130609E46967@dominion.thruhere.net>
 <jwvsil0r3gc.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
Message-ID: <5359ABC7-2F55-46DB-AFB8-95C0300A4BA5@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 13 aug. 2014, om 14:17 heeft Stefan Monnier <monnier@iro.umontreal.ca> het volgende geschreven:

>> So what you are saying is that the only reason it is needed is because some
>> distros choose to build DRM drivers as modules.  So as soon as they stop
>> doing that the problem goes away, right?
> 
> I think many people will be very happy to be able to get some visual
> feedback on their boot problems.  Having to connect a serial console is
> a deal breaker for most people.

As was said earlier in the thread, a proper DRM/KMS driver doesn't prevent that. The only thing preventing that would be:

a) kernels with graphics drivers disabled
b) kernels with graphics drivers as modules that get loaded late.

Please stop insinuation that DRM/KMS drivers can't handle boot messages.
