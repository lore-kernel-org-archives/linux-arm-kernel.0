From: robert.richter@cavium.com (Robert Richter)
Date: Thu, 5 Jan 2017 12:03:04 +0100
Subject: [PATCH v3] arm64: mm: Fix NOMAP page initialization
In-Reply-To: <CAKv+Gu_SmTNguC=tSCwYOL2kx-DogLvSYRZc56eGP=JhdrUOsA@mail.gmail.com>
References: <20161216165437.21612-1-rrichter@cavium.com>
 <CAKv+Gu_SmTNguC=tSCwYOL2kx-DogLvSYRZc56eGP=JhdrUOsA@mail.gmail.com>
Message-ID: <20170105110304.GT4930@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.01.17 13:56:39, Ard Biesheuvel wrote:
> Given that you are touching arch/arm/ as well as arch/arm64, could you
> explain why only arm64 needs this treatment? Is it simply because we
> don't have NUMA support there?

I haven't considered a solution for arch/arm yet. The fixes are
independent. But if that fix would be an excepted solution, it could
be implemented for arm then too. But as you said, since probably only
NUMA is affected, we might not need it there.

-Robert
