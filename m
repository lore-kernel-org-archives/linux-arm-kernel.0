From: bleung@chromium.org (Benson Leung)
Date: Fri, 8 May 2015 14:03:36 -0700
Subject: [PATCH v8 6/9] mailbox: Add NVIDIA Tegra XUSB mailbox binding
In-Reply-To: <CAL1qeaGfZtwNKxn=dT9DQ-c-j2X7Vi5jLtXx86zq2KscM8AFfg@mail.gmail.com>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
 <1430761002-9327-7-git-send-email-abrestic@chromium.org>
 <CANLzEksWtzSmz=OCuwVdY5RSG6gDrOoMyGsW3i9jMcjD3WtPKQ@mail.gmail.com>
 <CAL1qeaGfZtwNKxn=dT9DQ-c-j2X7Vi5jLtXx86zq2KscM8AFfg@mail.gmail.com>
Message-ID: <CANLzEkufD_k0M0E16EZ6=2UfjcY5SQ-Wtk=jneH4g0t830-8pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 8, 2015 at 1:53 PM, Andrew Bresticker <abrestic@chromium.org> wrote:
>
> The convention on Tegra is to use "nvidia,<chip>-<ip>" for each IP
> block.  Additionally, since the XUSB-related blocks on Tegra132 are
> identical to Tegra124, these devices on Tegra132 are 'compatible' with
> their Tegra124 variants.
>
> For some context, see Paul's comments in commit 193c9d23
> ("Documentation: DT bindings: add more Tegra chip compatible
> strings").

Ah, understood. Thanks for the clarification!

Reviewed-by: Benson Leung <bleung@chromium.org>



-- 
Benson Leung
Software Engineer, Chrom* OS
bleung at chromium.org
