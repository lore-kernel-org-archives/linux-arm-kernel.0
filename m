From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 10 Jul 2018 10:17:24 +0100
Subject: [PATCH v2 6/6] KVM: arm/arm64: vgic: Allow configuration of
 interrupt groups
In-Reply-To: <01925c40-7087-9b52-c59d-2a85005de642@redhat.com>
References: <1530697100-22419-1-git-send-email-christoffer.dall@arm.com>
 <1530697100-22419-7-git-send-email-christoffer.dall@arm.com>
 <7f875ead-d3cb-1fec-bc84-56e64526e6a7@arm.com>
 <20180709224836.GA26579@u002843.usa.arm.com>
 <51bb02d7-61d8-41bc-33e2-342364f659b5@arm.com>
 <01925c40-7087-9b52-c59d-2a85005de642@redhat.com>
Message-ID: <CAFEAcA_UFkHi=tMcLQXjODewuU9d01Kuv4cT2STjyF3YwhH5Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2018 at 10:12, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Christoffer, Marc,
>
> On 07/10/2018 10:33 AM, Marc Zyngier wrote:
>> On 09/07/18 23:48, Christoffer Dall wrote:
>>> What I would really like to know is whether this is really an issue or
>>> not.  Do people who run products based on KVM, such as RHEV, have any
>>> expectations about cross-kernel version migration?
>>
>> I'd like to know as well.
>
> Sorry I did not have time to review the series properly. My
> understanding is we generally care about migration between different
> kernels. For the ITS, we made the IIDR writable too to manage the ABI
> version properly. See ab01c6bdacc43c41c6b326889f4358f5afc38bf9. But
> maybe I missed the crux of the matter.

I think the question is whether we're doing this because
we think hypothetical users care, or because we know actual
real in-production users really care...

thanks
-- PMM
