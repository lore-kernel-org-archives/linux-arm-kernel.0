From: ndesaulniers@google.com (Nick Desaulniers)
Date: Wed, 29 Nov 2017 15:57:53 -0800
Subject: [PATCH 5/7] arm64: keep .altinstructions and .altinstr_replacement
In-Reply-To: <20171129234442.655-6-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171129234442.655-6-samitolvanen@google.com>
Message-ID: <CAKwvOd=PcTVZaMCtY7Wy-OEi7Dd1M4hVz8mpJCQR3M+dVROdmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 3:44 PM, Sami Tolvanen <samitolvanen@google.com> wrote:
> Make sure the linker doesn't remove .altinstructions or
> .altinstr_replacement when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is
> enabled.

This sounds like a bug in the original implementation of
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION? If so, this can likely get
merged regardless of the rest of the patchset, ie. gold support.
