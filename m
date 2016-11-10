From: james.morse@arm.com (James Morse)
Date: Thu, 10 Nov 2016 16:06:48 +0000
Subject: [PATCH v27 0/9] arm64: add kdump support
In-Reply-To: <20161104030025.GC381@linaro.org>
References: <20161102044959.11954-1-takahiro.akashi@linaro.org>
 <20161104030025.GC381@linaro.org>
Message-ID: <58249B18.6030702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 04/11/16 03:00, AKASHI Takahiro wrote:
> For easier testing, I pushed my patches to:
> https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
> https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump

Aha, thanks. That saved hopping around the mail archives to find the right set
of kdump patches.

> If anybody tries my patches, please let me know the result.

I gave this a spin on Juno with all the page-size va-bits combinations it
supports and used 'crash' to fish around in the resulting image. I also tested
the 4K/39 combination on Seattle that caused us problems in the past.

If its useful:
Tested-by: James Morse <james.morse@arm.com>

So the last thing is review/acks on patch 1
"memblock: add memblock_cap_memory_range()"?



Thanks,

James
