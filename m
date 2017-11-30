From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 09:38:59 -0800
Subject: [PATCH 1/7] kbuild: add ld-name macro and support for GNU gold
In-Reply-To: <CAKwvOdme29UPfaV1CCbMXRM=LzZJ-asytEjGm_F7ARN0WrMsEg@mail.gmail.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171129234442.655-2-samitolvanen@google.com>
 <CAKwvOdme29UPfaV1CCbMXRM=LzZJ-asytEjGm_F7ARN0WrMsEg@mail.gmail.com>
Message-ID: <20171130173859.GB90451@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 04:32:52PM -0800, Nick Desaulniers wrote:
> Right, but you're still only ever using one linker per build, correct?

Correct. LDFLAGS_GOLD makes it move convenient to add gold specific flags
without explicit $(ld-name) checks everywhere, but I'm fine with removing
it in v2.

Sami
