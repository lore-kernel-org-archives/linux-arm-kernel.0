From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Jan 2017 15:20:05 +0530
Subject: [PATCH v2 1/2] ARM: davinci: Allocate extra interrupts
In-Reply-To: <1484337612-11120-2-git-send-email-david@lechnology.com>
References: <1484337612-11120-1-git-send-email-david@lechnology.com>
 <1484337612-11120-2-git-send-email-david@lechnology.com>
Message-ID: <95440160-8346-fef8-27d2-fb17c0da38f6@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 January 2017 01:30 AM, David Lechner wrote:
> This allocates extra interrupts for mach-davinci. These extra interrupts
> are need for things like IIO triggers.

I am not really familiar with IIO triggers. Can you give some more
detail on what fails without this patch?

Thanks,
Sekhar
