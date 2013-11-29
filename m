From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 29 Nov 2013 13:39:19 +0530
Subject: [PATCH v6 4/6] gpio: davinci: add OF support
In-Reply-To: <CACRpkdZtfsvgYNMUnuwiYL=0dVe6KDPV92Ri0TpTHL8gRJeqkQ@mail.gmail.com>
References: <1385057731-4348-1-git-send-email-prabhakar.csengg@gmail.com>	<1385057731-4348-5-git-send-email-prabhakar.csengg@gmail.com>	<52932DB9.4090805@ti.com>	<5294950A.9070007@ti.com>	<5294D692.3080100@ti.com>
 <CACRpkdZtfsvgYNMUnuwiYL=0dVe6KDPV92Ri0TpTHL8gRJeqkQ@mail.gmail.com>
Message-ID: <52984BAF.4060306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 November 2013 01:16 PM, Linus Walleij wrote:
> On Tue, Nov 26, 2013 at 6:12 PM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On Tuesday 26 November 2013 06:03 PM, Grygorii Strashko wrote:
> 
>>> Actually, the same was proposed by Linus, but we've tried avoid such huge rework -
>>> by switching to one irq_domain per all banks for example.
>>
>> I didn't really read that proposal from Linus so if two people
>> independently suggested the same thing, there must be something worth
>> considering there :)
> 
> From a GPIO POV it's not such a big deal really, this approach is fine
> and the important thing is that we progress toward a more standard
> driver... it's more a question for the DT people IMO. I really like the
> current patch set.

Rob has acked v5 of this patch. So no objection from DT people too. My
concern was a bit futuristic. Since everyone is happy I think we can go
with the current patch itself.

Thanks,
Sekhar
