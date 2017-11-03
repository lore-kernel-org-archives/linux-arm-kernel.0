From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri, 3 Nov 2017 12:56:47 -0700
Subject: [PATCH 00/15] Add support for clang LTO
In-Reply-To: <20171103192634.u25go4tu7lgzl6ja@lakrids.cambridge.arm.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103175156.f44o7kuxgzym3pbt@lakrids.cambridge.arm.com>
 <20171103180913.whp2tdjjvs32f4lz@lakrids.cambridge.arm.com>
 <CAKwvOd=5CCMAA9n7=ocPO5UYmCmkNs8GLYrxXVZVZEeYCyisyA@mail.gmail.com>
 <20171103192634.u25go4tu7lgzl6ja@lakrids.cambridge.arm.com>
Message-ID: <20171103195647.GA137924@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 07:26:35PM +0000, Mark Rutland wrote:
> I guess that in Google you haven't tested on a platform with EL2
> available?

Correct. I'll look into this and include a fix in v2. Does this work on a
clang build without LTO?

Sami
