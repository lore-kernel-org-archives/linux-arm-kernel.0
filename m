From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 1 Jul 2014 18:03:46 +0100
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <CAFEAcA9KJpvKUDgk_ziT9LmOMmFEHVRdTz=OdVt1pm2GEf5JoQ@mail.gmail.com>
References: <20140328184517.GA27219@cbox> <20140611065412.GA24286@lvm>
 <53981043.3010300@redhat.com> <9801429.iblEns5zC3@wuerfel>
 <53B18E03.4050902@jonmasters.org> <20140630204647.GA19743@cbox>
 <CAFEAcA9KJpvKUDgk_ziT9LmOMmFEHVRdTz=OdVt1pm2GEf5JoQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1407011800510.8923@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Jun 2014, Peter Maydell wrote:
> On 30 June 2014 21:46, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > Seems like we should stick a note in there about being UEFI compatible
> > requires an RTC.  We went this far before Peter raised the issue with
> > noone else realizing it, so it seems like a good idea to me.
> 
> How about:
> =====
> Guest OSes in the VM image should rely on the UEFI RTC API for
> real time clock services. (To provide that API, the VM system will
> likely need to implement some real time clock device, but the
> details of these are a private implementation issue between it
> and its associated UEFI implementation.)

I don't see why we need to add the text within brackets: it is out of
scope for this document.
