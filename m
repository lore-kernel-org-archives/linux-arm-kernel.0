From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 17 Aug 2016 14:01:18 -0500
Subject: [PATCH v10 0/8] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <20160811105848.GA25680@red-moon>
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
 <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com>
 <510fa357-a729-4ce1-7c10-4cef06feb7b7@linaro.org>
 <CADyBb7tZDT2LMGnsWW_orR37dsfseijLEjzn59rLW9tbbxKVPQ@mail.gmail.com>
 <20160811105848.GA25680@red-moon>
Message-ID: <57B4B47E.5030100@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi wrote:
> I do not think you need a v11 just to remove the drivers/acpi/arm64
> directory creation, you need to get Daniel/Thomas review/ack on
> the respective patches though, I do not see the point of churning
> out another series just because drivers/acpi/arm64 is now created
> in the IORT patch series. If v10 is ok you will rebase it on top of
> Tomasz's series and mention the dependency in the respective pull
> request.
>
> If there is need for a v11 following Daniel/Thomas review yes,
> you can proceed as above.

What's the latest on this patchset?  I really want them in 4.9.  Is 
everything queued up, or are still issues that need to be resolved.

Who will be merging these patches?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
