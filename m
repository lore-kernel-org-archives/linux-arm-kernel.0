From: Pawel.Moll@arm.com (Pawel Moll)
Date: Sat, 21 Apr 2012 09:32:17 +0100
Subject: [PATCH] watchdog: mpcore: Add DT bindings for ARM mpcore watchdog
In-Reply-To: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
Message-ID: <1334997137.10278.3.camel@rojo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Morning,

Dnia 2012-04-20, pi? o godzinie 20:12 +0530, Viresh Kumar pisze:
> This patch adds Device tree bindings for ARM Mpcore watchdog. It also updates
> documentation for bindings.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  .../bindings/watchdog/arm-mpcore-wdt.txt           |   19 +++++++++++++++++++
>  drivers/watchdog/mpcore_wdt.c                      |   10 ++++++++++

Bindings for the MPCore TWD already exist in the tree:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=d8e0364364d333feb4564bb7d7d983182b34427e

I've Cc-ed Marc Zyngier, who is the author of the patch.

Regards

Pawel

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
