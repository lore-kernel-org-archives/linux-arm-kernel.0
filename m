From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Oct 2014 18:10:13 +0100
Subject: [PATCH v2] arm64: mm: use macro instead of if judgement of
 ZONE_DMA
In-Reply-To: <CAGZxSSSBpCvJt=PFbihTmPneJqiocU8VZSDHpXgkf5dhWZ850Q@mail.gmail.com>
References: <CAGZxSSSBpCvJt=PFbihTmPneJqiocU8VZSDHpXgkf5dhWZ850Q@mail.gmail.com>
Message-ID: <20141016171012.GE5252@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 10:41:01AM +0100, Yifan Zhang wrote:
> if disable CONFIG_ZONE_DMA, ZONE_DMA becomes undefined.

I agree that this is the case but can you explain why you need to
disable ZONE_DMA? It currently is def_bool y, so it cannot be disabled
unless you hack the Kconfig.

-- 
Catalin
