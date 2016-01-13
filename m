From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 13 Jan 2016 08:40:23 +0000
Subject: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
In-Reply-To: <CAGDN=zY5wVwOC=o8f1nmYyUrgo5gdRVgB7W1jsKu0RKyazp+BA@mail.gmail.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com> <56954D18.1010306@arm.com>
 <CAGDN=zYVvU9=Qj8_szqYW3qh7G=phr_Bc_dm8+KVO=yhp=YTVQ@mail.gmail.com>
 <569554D0.2000406@arm.com>
 <CAGDN=zY5wVwOC=o8f1nmYyUrgo5gdRVgB7W1jsKu0RKyazp+BA@mail.gmail.com>
Message-ID: <56960D77.5010805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/16 20:01, Tuan Phan wrote:
> On Tue, Jan 12, 2016 at 11:32 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> > Right. In which case please document this properly in the commit log.
>> >
> Do we need to post a new patch with updated description or wait Rafael's input?

Given that there is quite a few comments on this series already, it
would make sense to update it and repost it.

> -- CONFIDENTIALITY NOTICE: This e-mail message, including any
> attachments, is for the sole use of the intended recipient(s) and
> contains information that is confidential and proprietary to Applied
> Micro Circuits Corporation or its subsidiaries. It is to be used solely
> for the purpose of furthering the parties' business relationship. All
> unauthorized review, use, disclosure or distribution is prohibited. If
> you are not the intended recipient, please contact the sender by reply
> e-mail and destroy all copies of the original message.

And please fix your email setup. By the look of it, I'm not even
supposed to read this.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
