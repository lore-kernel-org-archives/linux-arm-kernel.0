From: cinifr@gmail.com (cinifr)
Date: Fri, 13 Sep 2013 22:55:07 +0800
Subject: [PATCH 3/4] Add physical count arch timer support for clocksource
 in ARMv7.
In-Reply-To: <523315CD.8010704@arm.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-4-git-send-email-cinifr@gmail.com>
 <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
 <CAK3cCBwu4somtfc9J1ZDVcC-iYD1qDJwSWzWeOomTqY9tQA2kg@mail.gmail.com>
 <5231EE43.5090900@arm.com>
 <CAK3cCBzr8_LTYarZDgPYZY7_-5Qco_Qw+ACi=c2uOrn7MqwkBg@mail.gmail.com>
 <5232DB49.4050701@arm.com>
 <CAK3cCBw4EKypLmhf4L5_P3d27QzsrB+ZxUTgF58YhmUhBa00xQ@mail.gmail.com>
 <523315CD.8010704@arm.com>
Message-ID: <CAK3cCBwsbsdBoRX3Gnz5KpUVMQk0pnuUD+2WhZscBA+pDaat5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> This doesn't change the fact that using the physical timer/counter in a
> VM is (or can be) horribly expensive, and should be avoided at all cost.
>
I will remove suport phy timer counter patch and try to fix it in
bootloader.  I agree that is elegant only vct is be used.in kernel
now.
