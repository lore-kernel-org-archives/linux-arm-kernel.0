From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 13 Nov 2017 13:05:19 +0000
Subject: [PATCH v4 00/21] SError rework + RAS&IESB for firmware first
 support
In-Reply-To: <20171113112946.GK14144@cbox>
References: <20171019145807.23251-1-james.morse@arm.com>
 <5A049B20.6000501@arm.com> <20171113112946.GK14144@cbox>
Message-ID: <CAFEAcA_yRT7829=reU=vnAiHWy-9oP1G84v0w_ST8C3VxpskNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2017 at 11:29, Christoffer Dall <cdall@linaro.org> wrote:
> I'm thinking this is analogous to migrating a VM that uses an irqchip in
> userspace and has set the IRQ or FIQ lines using KVM_IRQ_LINE.  My
> feeling is that this is also not supported today.

Oops, yes, we completely forgot about migration when we added
that feature... I think you're right that we won't get that right.

thanks
-- PMM
