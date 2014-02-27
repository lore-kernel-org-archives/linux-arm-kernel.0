From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 27 Feb 2014 11:05:06 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <201402270830.16903.arnd@arndb.de>
References: <20140226183454.GA14639@cbox>
 <CABGGisxHOVqLcG7hVAuAzdeic41KWSLLBSjQLSJQcjTXLhNCow@mail.gmail.com>
 <20140226222147.GE16149@cbox> <201402270830.16903.arnd@arndb.de>
Message-ID: <530F0DD2.5040402@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 27/02/2014 08:30, Arnd Bergmann ha scritto:
> I guess the real question is whether we are interested in running Windows RT
> in VM guests. I don't personally expect MS to come out with a port for
> this spec, no matter what we do, but some of you may have information I don't.

Given enough firmware and driver support there's no reason why Windows 
and Linux should be any different---they certainly aren't on x86.

Right now Windows on ARM is just tablets and hence RT; but things might 
change for server-based ARM.  So Windows support as a VM should 
definitely be on the table, but so is writing custom drivers: you 
certainly will be able at some point to build virtio drivers for ARM, 
and use them with this spec.

Paolo
