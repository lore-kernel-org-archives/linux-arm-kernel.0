From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 29 Jul 2014 14:00:38 +0300
Subject: [PATCH 2/2] remoteproc: add support to handle internal memories
In-Reply-To: <1404836521-59637-3-git-send-email-s-anna@ti.com>
References: <1404836521-59637-1-git-send-email-s-anna@ti.com>
 <1404836521-59637-3-git-send-email-s-anna@ti.com>
Message-ID: <CAK=WgbY-WmcJdnLHDf1CSkJqNBUeUMPTLcEZyLGKnECbxH1OAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Tue, Jul 8, 2014 at 7:22 PM, Suman Anna <s-anna@ti.com> wrote:
> A remote processor may need to load certain firmware sections into
> internal memories (eg: RAM at L1 or L2 levels) for performance or
> other reasons.

Can you please provide as much details as you can about the scenario
you need this for? what hardware, what sections, which specific
memory, what's the use case, numbers, sizes, everything.

I'd like to better understand the use case please.

Thanks,
Ohad.
