From: npiggin@gmail.com (Nicholas Piggin)
Date: Thu, 30 Nov 2017 12:10:29 +1000
Subject: [PATCH 3/7] kbuild: fix LD_DEAD_CODE_DATA_ELIMINATION with GNU
 gold
In-Reply-To: <20171129234442.655-4-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171129234442.655-4-samitolvanen@google.com>
Message-ID: <20171130121029.3647ea43@roar.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Nov 2017 15:44:38 -0800
Sami Tolvanen <samitolvanen@google.com> wrote:

> Don't remove .head.text or .exitcall.exit when linking with --gc-sections,
> and include .init.text.* in .init.text and .init.rodata.* in .init.rodata.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Fine by me, if you consider my other comments.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
