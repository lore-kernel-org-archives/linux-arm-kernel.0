From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 13 Jun 2016 18:09:29 +0200
Subject: [PATCH 00/10] ARM: V7M: Support caches
In-Reply-To: <1465830189-20128-1-git-send-email-vladimir.murzin@arm.com>
References: <1465830189-20128-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <575EDAB9.2070809@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 06/13/2016 05:02 PM, Vladimir Murzin wrote:
> Hi,
>
> This patch set allows M-class cpus benefit of optional cache support.
> It originaly was written by Jonny, I've been keeping it localy mainly
> rebasing over Linux versions.
>
> The main idea behind patches is to reuse existing cache handling code
> from v7A/R. In case v7M cache operations are provided via memory
> mapped interface rather than co-processor instructions, so extra
> macros have been introduced to factor out cache handling logic and
> low-level operations.
>
> Along with the v7M cache support the first user (Cortex-M7) is
> introduced.
>
> Patches were tested on MPS2 platform with Cortex-M3/M4/M7. The later
> one showed significant boot speed-up.
>
> Based on 4.7-rc3.
>
> Thanks!
> Vladimir
>

Thanks for the series.
Did you change something in those patches compare to patches you sent in 
the RFC ?

Regards.

Alex
