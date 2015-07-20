From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 20 Jul 2015 07:06:21 -0500
Subject: [Linaro-acpi] [PATCH v3 0/8] Add self-probe
 infrastructure and stacked irqdomain support for ACPI based GICv2/3
 init
In-Reply-To: <55ACBA00.4080101@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
 <CAOZdJXXxJxxc9KAQK1VY9iTTVdj-FbpFpoWcexGMrqOS0TgDEQ@mail.gmail.com>
 <55ACBA00.4080101@linaro.org>
Message-ID: <55ACE43D.4090306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hanjun Guo wrote:

> I got a question, do you test GICv3 in this patch set too?
> if yes, that will be really great!

Yes, I specifically tested GICv3 on an ACPI-only system.

> Just let you know, I'm still working on this patch set to try
> to address Marc's comments (unify DT and ACPI to match the domain),
> I'm not sure if any obstacles ahead, I will let you know the progress.

Just CC me on all patches, and I will test each version.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
