From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 1 Jul 2014 18:10:19 +0100
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <alpine.DEB.2.02.1407011800510.8923@kaball.uk.xensource.com>
References: <20140328184517.GA27219@cbox> <20140611065412.GA24286@lvm>
 <53981043.3010300@redhat.com> <9801429.iblEns5zC3@wuerfel>
 <53B18E03.4050902@jonmasters.org> <20140630204647.GA19743@cbox>
 <CAFEAcA9KJpvKUDgk_ziT9LmOMmFEHVRdTz=OdVt1pm2GEf5JoQ@mail.gmail.com>
 <alpine.DEB.2.02.1407011800510.8923@kaball.uk.xensource.com>
Message-ID: <CAFEAcA9v_xY36iYpCXOt5JTNE4ehiQh7k3LtkyF+=d50LMm=GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 July 2014 18:03, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> On Mon, 30 Jun 2014, Peter Maydell wrote:
>> How about:
>> =====
>> Guest OSes in the VM image should rely on the UEFI RTC API for
>> real time clock services. (To provide that API, the VM system will
>> likely need to implement some real time clock device, but the
>> details of these are a private implementation issue between it
>> and its associated UEFI implementation.)
>
> I don't see why we need to add the text within brackets: it is out of
> scope for this document.

The intention is to be an informative note, not normative text
(I'm happy if we want to format the text to make that clearer,
with some sort of NOTE: markup). I'd like VM implementors
reading this spec to make the correct decisions even if they
don't happen to know inside-out the details of the UEFI
specification and what exactly UEFI demands of the hardware,
and I think it's worth adding the occasional clarifying sentence
even if it doesn't strictly speaking add any extra rules to the
specification.

thanks
-- PMM
