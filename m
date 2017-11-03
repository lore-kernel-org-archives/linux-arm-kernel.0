From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri, 3 Nov 2017 13:29:02 -0700
Subject: [PATCH 13/15] arm64: add a workaround for GNU gold with
 ARM64_MODULE_PLTS
In-Reply-To: <CAKv+Gu_cov8S0CbgeKq8PQBU8Z2pKJGqgYtXK1oE2ieB3VesKw@mail.gmail.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-17-samitolvanen@google.com>
 <CAKv+Gu_cov8S0CbgeKq8PQBU8Z2pKJGqgYtXK1oE2ieB3VesKw@mail.gmail.com>
Message-ID: <20171103202902.GC137924@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 08:09:42PM +0000, Ard Biesheuvel wrote:
> This is not true. Even when RANDOMIZE_MODULE_REGION_FULL is not
> enabled, we may need module PLTs.

Got it. PLTs themselves are not a problem with gold, only the bug when
processing a linker script of this particular format. I'll see if I can
find a better workaround for this for v2.

Sami
