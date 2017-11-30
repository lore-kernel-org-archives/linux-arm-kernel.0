From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 09:48:34 -0800
Subject: [PATCH 5/7] arm64: keep .altinstructions and .altinstr_replacement
In-Reply-To: <20171130115827.709f1818@roar.ozlabs.ibm.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171129234442.655-6-samitolvanen@google.com>
 <CAKwvOd=PcTVZaMCtY7Wy-OEi7Dd1M4hVz8mpJCQR3M+dVROdmg@mail.gmail.com>
 <20171130115827.709f1818@roar.ozlabs.ibm.com>
Message-ID: <20171130174834.GC90451@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 11:58:27AM +1000, Nicholas Piggin wrote:
> So yes please if it's not too much trouble, could you remove
> the "gold" name from the generic patch and put it at the front
> of the series with this arm64 patch.

Sure, I'll do this in v2.

> Possibly then you could also do a 3rd patch to allow arm64 to
> select it if it's working with gcc?

These patches only fix the issues I ran into with clang and gold
when testing on a single device.  I feel like more testing would
be needed before enabling this by default for arm64.

Sami
