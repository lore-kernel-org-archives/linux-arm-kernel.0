From: robherring2@gmail.com (Rob Herring)
Date: Tue, 17 Jul 2012 13:02:12 -0500
Subject: [PATCH v2 05/15] ARM: integrator: use fixed PCI i/o mapping
In-Reply-To: <20120717170413.GG14624@mudshark.cambridge.arm.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <1342231451-28861-6-git-send-email-robherring2@gmail.com>
 <CACRpkda_to3CzfhvOh-NDx_7Qz+Reg6m1k+uH2stRFy8KSqQmQ@mail.gmail.com>
 <20120717170413.GG14624@mudshark.cambridge.arm.com>
Message-ID: <5005A8A4.6040608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2012 12:04 PM, Will Deacon wrote:
> On Sat, Jul 14, 2012 at 10:49:47PM +0100, Linus Walleij wrote:
>> On Sat, Jul 14, 2012 at 4:04 AM, Rob Herring <robherring2@gmail.com> wrote:
>>
>>> From: Rob Herring <rob.herring@calxeda.com>
>>>
>>> Move integrator PCI to fixed i/o mapping and remove io.h.
>>>
>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>
>> I think the PCI bus on my Integrator/AP is tilted and not suitable
>> for tests. But IIRC Will Deacon actually has one of these machines
>> and managed to get ethernet going on it. Maybe he can even test
>> this patch?
> 
> I can try digging out my integrator at the weekend if you like. Are these
> patches sitting in a branch anywhere that I can grab?
> 

git://sources.calxeda.com/kernel/linux.git io-cleanup-pci

Rob
