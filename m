From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 16 Apr 2018 15:16:48 -0700
Subject: [PATCH] ARM: B15: Update to support Brahma-B53
In-Reply-To: <20180223204110.6350-1-f.fainelli@gmail.com>
References: <20180223204110.6350-1-f.fainelli@gmail.com>
Message-ID: <20180416221648.31573-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Feb 2018 12:41:10 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The B53 CPU design supports up to 8 processors, which moved the RAC_FLUSH_REG
> offset 0x4 bytes below to make room for a RAC_CONFIG2_REG to control RAC
> settings for CPU4-7.
> 
> Lookup the processor type (B15 or B53) and adjust the RAC_FLUSH_REG offset
> accordingly, if we do not know the processor, bail out.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/next, thanks!
--
Florian
