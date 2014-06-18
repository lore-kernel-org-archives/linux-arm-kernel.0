From: lho@apm.com (Loc Ho)
Date: Wed, 18 Jun 2014 16:30:50 -0700
Subject: [PATCH v3 3/4] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <20140618223112.GM24024@pd.tnic>
References: <1401761660-11515-1-git-send-email-lho@apm.com>
 <1401761660-11515-2-git-send-email-lho@apm.com>
 <1401761660-11515-3-git-send-email-lho@apm.com>
 <1401761660-11515-4-git-send-email-lho@apm.com>
 <20140618221046.GL24024@pd.tnic>
 <CAPw-ZT=k=27NY5OgV2Tp4gsjf3wSTmgN3FM46qJq8HEQWHTYDw@mail.gmail.com>
 <20140618223112.GM24024@pd.tnic>
Message-ID: <CAPw-ZTmqEuXCZGPGXBJAe4+_L+4LZfrPUp=JFKHjnGXqADr0zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

>> One more thing, if you going to pull this in, please use version 4 as
>> that fixes the PMD (CPU L1/L2) error report and clearing.
>
> Ah, I have a v4 too in my mbox. cool.
>
> Please ping me when the atomic scrub lands in some maintainers tree so
> that we can track it/point to it.

Did the EDAC support for ARM64 made to any GIT tree yet?

>> Should I ping a device tree maintainer? If so, who would that be?
>
> $ ./scripts/get_maintainer.pl -f Documentation/devicetree/
> Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND...)
> Pawel Moll <pawel.moll@arm.com> (maintainer:OPEN FIRMWARE AND...)
> Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND...)
> Ian Campbell <ijc+devicetree@hellion.org.uk> (maintainer:OPEN FIRMWARE AND...)
> Kumar Gala <galak@codeaurora.org> (maintainer:OPEN FIRMWARE AND...)
> Randy Dunlap <rdunlap@infradead.org> (maintainer:DOCUMENTATION)
> devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND...)
> linux-doc at vger.kernel.org (open list:DOCUMENTATION)
> linux-kernel at vger.kernel.org (open list)

Also, can you review the DT node of this EDAC driver as you seems to
review the GPIO DT node as well? Please review version 4 of the
posting.

-Loc
