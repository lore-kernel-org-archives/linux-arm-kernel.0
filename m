From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 26 Nov 2014 17:14:40 +0000
Subject: [PATCH 4/7] KVM: arm64: guest debug, add SW break point support
In-Reply-To: <20141126160720.GD3245@hawk.usersys.redhat.com>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-5-git-send-email-alex.bennee@linaro.org>
 <20141126160720.GD3245@hawk.usersys.redhat.com>
Message-ID: <CAFEAcA-xV80Z3j52H5yh2e+JxOo5=inZNcM54HkOa2U2rBvKhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 November 2014 at 16:07, Andrew Jones <drjones@redhat.com> wrote:
> There appears to be a typo in the ARM ARM. Subsection "Software
> Breakpoint Instruction exception" of D1.10.4 says BRK (ESR_EL2_EC_BRK64)
> is 0x39, but the table above that has it correctly as 0x3c.

Thanks for pointing out this typo -- I've reported it to the
appropriate documentation people.

-- PMM
