From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 30 Jun 2014 22:14:01 +0100
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <20140630204647.GA19743@cbox>
References: <20140328184517.GA27219@cbox> <20140611065412.GA24286@lvm>
 <53981043.3010300@redhat.com> <9801429.iblEns5zC3@wuerfel>
 <53B18E03.4050902@jonmasters.org> <20140630204647.GA19743@cbox>
Message-ID: <CAFEAcA9KJpvKUDgk_ziT9LmOMmFEHVRdTz=OdVt1pm2GEf5JoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2014 21:46, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> Seems like we should stick a note in there about being UEFI compatible
> requires an RTC.  We went this far before Peter raised the issue with
> noone else realizing it, so it seems like a good idea to me.

How about:
=====
Guest OSes in the VM image should rely on the UEFI RTC API for
real time clock services. (To provide that API, the VM system will
likely need to implement some real time clock device, but the
details of these are a private implementation issue between it
and its associated UEFI implementation.)
=====

?

thanks
-- PMM
