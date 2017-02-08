From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 8 Feb 2017 10:07:50 -0600
Subject: [PATCH 1/2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
In-Reply-To: <87lgtg7l1c.fsf@on-the-bus.cambridge.arm.com>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <7151be59-000c-d50b-f8f5-5fef0c053d91@arm.com>
 <f9504cde-a87a-ba99-2f72-fc3029ef5fe5@codeaurora.org>
 <20170208133306.GE15459@leverpostej>
 <e16986de-31fa-8d34-05be-aa8a585500d4@codeaurora.org>
 <87lgtg7l1c.fsf@on-the-bus.cambridge.arm.com>
Message-ID: <f1879b37-995b-18ad-18d9-d88a41ef10c7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2017 09:35 AM, Marc Zyngier wrote:
> Interesting. How will you guarantee that nobody will ever want to run a
> mainline kernel on this box after a certain date? Self-destruct timer?
> ;-)
>
> As someone who runs mainline on HW that exceeded its "sell-by" date by a
> few decades, I'm genuinely interested.

The affected chips are pre-production and are only available to select 
customers for a limited time.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
