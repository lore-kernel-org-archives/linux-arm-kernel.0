From: samitolvanen@google.com (Sami Tolvanen)
Date: Mon, 20 Nov 2017 13:04:00 -0800
Subject: [PATCH v2 00/18] Add support for clang LTO
In-Reply-To: <20171120152139.mfqthlbneeeiythr@lakrids.cambridge.arm.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171120152139.mfqthlbneeeiythr@lakrids.cambridge.arm.com>
Message-ID: <20171120210400.GE89108@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 03:21:40PM +0000, Mark Rutland wrote:
> Would it be possible to split this into:
> 
> (1) (basic) arm64 clang support
> (2) gold support (no LTO)
> (3) LTO support
> 
> ... with any necessary workarounds added as-required to the relevant
> series?

Absolutely. I'll split the patches into more sensible sets.

Sami
