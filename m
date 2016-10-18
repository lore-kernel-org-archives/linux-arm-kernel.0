From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 18 Oct 2016 12:00:02 +0200
Subject: how to enable suspend to ram for arm-64 bits
In-Reply-To: <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
Message-ID: <20161018100002.GA4347@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >b. in arm64, if some platform has its own suspend flow,  couldn't it
> >adopts arm/match-xxx to register its own global suspend method?
> >
> 
> No, PSCI is highly recommended.

Relying on firmware for suspend on x86 was a great disaster, lets not repeat
that mistake. arm32 has better powermanagement than x86 ever will (see Nokia N900
for example) -- feel free to copy that code from arm32.

Best regards,

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
