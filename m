From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Sun, 7 Nov 2010 10:00:26 -0600
Subject: [PATCH 2/6] OMAP3: hwmod data: Add mmu for iva2 and isp
In-Reply-To: <4CD5A96D.1000806@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-3-git-send-email-omar.ramirez@ti.com>
	<4CD5A96D.1000806@ti.com>
Message-ID: <AANLkTinn4_s-PX08H62AL-tn+8wxXXQjhUNq6d+aDOo+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 6, 2010 at 2:15 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
>>
>> Add mmu hwmod data for iva2 and isp.
>
> s/iva2/iva/

Where this terminology can be found? I'm basing this naming on what
was there or TRM. For omap3 there is no such thing as iva, it is iva2.

I can change it but I just wanted to know.

> If you do need the version information, you should use the rev field in the
> hwmod class.

I don't.

> All the comments about the structure fields order I did on your mailbox
> series will apply here as well.

Same for my comments.

Regards,

Omar
