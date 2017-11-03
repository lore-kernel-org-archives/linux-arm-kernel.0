From: ndesaulniers@google.com (Nick Desaulniers)
Date: Fri, 3 Nov 2017 11:11:45 -0700
Subject: [PATCH 00/15] Add support for clang LTO
In-Reply-To: <20171103180913.whp2tdjjvs32f4lz@lakrids.cambridge.arm.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103175156.f44o7kuxgzym3pbt@lakrids.cambridge.arm.com>
 <20171103180913.whp2tdjjvs32f4lz@lakrids.cambridge.arm.com>
Message-ID: <CAKwvOd=5CCMAA9n7=ocPO5UYmCmkNs8GLYrxXVZVZEeYCyisyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 3, 2017 at 11:09 AM, Mark Rutland <mark.rutland@arm.com> wrote:
ently compile
> What's the minimum set of patches necessary to work with clang (ignoring
> LTO)?

If you have a build of clang-5, then just patch 7 in this series to
work around the last compiler bug.  If you build clang from source
from master, ToT, for arm64, then none. :)
