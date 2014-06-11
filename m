From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 11 Jun 2014 15:14:40 +0100
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <CACxGe6tPQFbbUcJJmoxkAdVAp9b1AcGB_Xdwh_Mu4m6P1j_zRA@mail.gmail.com>
References: <20140328184517.GA27219@cbox>
 <CAFEAcA-isiLax0UASTMkedwGXWOaBdR7N1t2o87XYDkj5nt5ig@mail.gmail.com>
 <53973AA8.9020301@codeaurora.org>
 <CAFEAcA8RttCvbOAw-m-W6C-mh1o4hj6nqGMkDbRsSF6ZoQZ7Kg@mail.gmail.com>
 <539754E5.3030408@redhat.com>
 <CACxGe6tPQFbbUcJJmoxkAdVAp9b1AcGB_Xdwh_Mu4m6P1j_zRA@mail.gmail.com>
Message-ID: <CAFEAcA-vFmoci85x8bvNcL7wAH2UHj30cJxxnw0u876P92iBXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 June 2014 12:33, Grant Likely <grant.likely@linaro.org> wrote:
> In practical terms, yes the VM needs to provide an RTC interface, but
> I don't think it needs to appear in this spec, even if the kernel
> accesses it directly. Portable images should use the UEFI service.

I think it might helpful to include some implementation notes
to the effect that the VM needs to provide certain things to
the associated UEFI implementation but that these aren't
part of the specification and the guest OS is expected to
use the UEFI interfaces, just for the sake of clarity for people
who aren't too familiar with what UEFI requires or provides.

thanks
-- PMM
