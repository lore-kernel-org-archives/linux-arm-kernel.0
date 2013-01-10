From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 10 Jan 2013 10:17:09 +0000
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <97E481BC-F14D-4866-B44B-878833CA81DC@suse.de>
References: <1357769438.18196.5@snotra>
 <97E481BC-F14D-4866-B44B-878833CA81DC@suse.de>
Message-ID: <CAFEAcA87t5VP5TCUjtNHDPHM=uPSXirNSD5=GWgwZaHF-wOo6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2013 22:30, Alexander Graf <agraf@suse.de> wrote:
> In fact, in this particular case one could merge all of the patches except for the
> particular ioctl implementation and just give the respective addresses default
> values until there is an API to set them, similar to how we did things with PVR
> in the beginning.

That's what we started with and we got review comments saying "yuck,
don't hard code this"...

-- PMM
