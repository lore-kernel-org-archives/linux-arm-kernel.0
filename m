From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Jul 2014 00:07:13 +0200
Subject: [PATCH] regulator: convert to use gpio_desc internally
In-Reply-To: <CAAVeFuLc9GVMXQt=6oSkcHwH4ZpoOQkpj7uivUHZW+UkmEdDrw@mail.gmail.com>
References: <E1X1IOQ-0007fV-1w@rmk-PC.arm.linux.org.uk>
 <CACRpkdY_w=Vjv0fL5Ay-CkCpvuyjvwyBhOd4wYr0LcmJD6i4qA@mail.gmail.com>
 <20140630163931.GD32514@n2100.arm.linux.org.uk>
 <CACRpkda5BjAwphVEkCg6-oUR0yN=RMhjP6FL=Oripy7bQ-aSng@mail.gmail.com>
 <CAAVeFuK8YPFh3gHRt7_n00SBN6raGj2KxU_rY3GFrQq4dT3LTA@mail.gmail.com>
 <20140701111041.GL23300@sirena.org.uk>
 <CAAVeFuLc9GVMXQt=6oSkcHwH4ZpoOQkpj7uivUHZW+UkmEdDrw@mail.gmail.com>
Message-ID: <CACRpkdb5BNr=c90x1N3foppK8jJ2nRTsr72VmDmxqBdh_hCMAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 1, 2014 at 2:27 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Tue, Jul 1, 2014 at 8:10 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Tue, Jul 01, 2014 at 09:59:01AM +0900, Alexandre Courbot wrote:

>> I don't see security as a big deal - so long as normal, well written
>> code gets the benefit of the access protection I think we're doing
>> enough.  If something jumpst through hoops to bypass it then it's buggy
>> but fundamentally we have to trust the kernel to at least some extent.
>
> The security consideration apart, making GPIOs obtained through gpiod
> shareable seems to be a good way to solve the issue we are having
> here.
>
> Linus, if you agree with the idea I can try to give it a shot sometime
> this week.

I'm game for this approach. I hope this can get Russell's original
problem out of the way.

Yours,
Linus Walleij
