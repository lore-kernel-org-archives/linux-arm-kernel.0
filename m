From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Fri, 16 Mar 2012 13:14:20 +0200
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <alpine.LFD.2.02.1203161129010.2466@ionos>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-2-git-send-email-mturquette@linaro.org>
 <CACRpkdbXq7zX_XrvAOJc7U6=T0Aaoq+U9_GmZS4fVmVd_arC7A@mail.gmail.com>
 <alpine.LFD.2.02.1203161129010.2466@ionos>
Message-ID: <CAP245DXV5oE+-y+PQCcSM016h-J+UgTi1efmdrcyeQge4k1Cfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 12:29 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 16 Mar 2012, Linus Walleij wrote:
>
>> On Fri, Mar 16, 2012 at 7:11 AM, Mike Turquette <mturquette@linaro.org> wrote:
>>
>> > Provide documentation for the common clk structures and APIs. ?This code
>> > can be found in drivers/clk/ and include/linux/clk*.h.
>>
>> Acked-by: Linus Wallej <linus.walleij@linaro.org>
>> For this three-piece v7 patchset.
>>
>> It already does magnitudes more advanced stuff than what I need
>> so I'm pretty pleased, any remaining details can surely be ironed out
>> in-tree.
>
> Ack. We really need to get that in now and sort out the details in
> tree otherwise we will never finish that thing.
>

Thomas, Russell, Arnd,

Can we shoe-horn this thing into 3.4 (it is a bit late, i know) so
that platform ports can gather speed? Several people are waiting for a
somewhat stable version before starting their ports.

And what is the path into mainline - will Russell carry it or Arnd
(with Russell's blessing)?

Regards,
Amit
