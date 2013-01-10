From: agraf@suse.de (Alexander Graf)
Date: Thu, 10 Jan 2013 12:06:29 +0100
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <CAFEAcA87t5VP5TCUjtNHDPHM=uPSXirNSD5=GWgwZaHF-wOo6A@mail.gmail.com>
References: <1357769438.18196.5@snotra>
 <97E481BC-F14D-4866-B44B-878833CA81DC@suse.de>
 <CAFEAcA87t5VP5TCUjtNHDPHM=uPSXirNSD5=GWgwZaHF-wOo6A@mail.gmail.com>
Message-ID: <B6B1DA30-3BAB-4C5B-ACB5-3B07766A3C3A@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 10.01.2013 um 11:17 schrieb Peter Maydell <peter.maydell@linaro.org>:

> On 9 January 2013 22:30, Alexander Graf <agraf@suse.de> wrote:
>> In fact, in this particular case one could merge all of the patches except for the
>> particular ioctl implementation and just give the respective addresses default
>> values until there is an API to set them, similar to how we did things with PVR
>> in the beginning.
> 
> That's what we started with and we got review comments saying "yuck,
> don't hard code this"...

And you shouldn't in the long run. But as an intermediate step, it's the best solution IMHO.

Either way, let's just finally get something in that doesn't clutter the global namespace :).

Alex

> 
> -- PMM
