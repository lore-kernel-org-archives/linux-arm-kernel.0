From: ruslan.bilovol@ti.com (Ruslan Bilovol)
Date: Wed, 6 Feb 2013 17:11:44 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: SoC name and revision unification
In-Reply-To: <20130205235626.GS25185@atomide.com>
References: <1359660284-5225-1-git-send-email-ruslan.bilovol@ti.com>
 <1359660284-5225-2-git-send-email-ruslan.bilovol@ti.com>
 <20130205235626.GS25185@atomide.com>
Message-ID: <CAB=otbQHmBdDs7crwXLni4sNDFUeM+56eEGhcOKAHjEDpX1R0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 6, 2013 at 1:56 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Ruslan Bilovol <ruslan.bilovol@ti.com> [130131 11:28]:
>> This is a long story where for each new generation of
>> OMAP we used different approaches for creating
>> strings for SoCs names and revisions that this patch
>> fixes. It makes future exporting of this information
>> to SoC infrastructure easier.
>
> Maybe use name soc_name and soc_rev instead and make
Yes agree, will change in next patchset

> cpu_name and cpu_rev local to the functions?
> That would reduce some churn here.
This is used in second patch in this series

>
> Also this does not apply to my omap-for-v3.9/soc
> branch. Care to update this (and possibly the second one)
> against that?
Yes, I will rebase the patches on top of this branch.

>
> Regards,
>
> Tony
