From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Aug 2013 17:34:54 +0100
Subject: [ARM ATTEND] DT binding management and long-term stability
Message-ID: <20130808163454.GC27325@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[resending with lakml included]

With the current move to devicetree, several binding additions or
changes appear every day, hampering the use of a current dtb with a
future kernel, or a current kernel with a future dtb, even for a fixed
platform. To solve this and ensure long-term stability, we must have a
stable set of bindings that may be relied upon to function from release
to release. This is critical for the long term health of the ARM Linux
port.

Several steps on path to achieving this have been discussed so far in
person or on list, and there needs to be some consensus reached by the
community as to the steps that still need to be taken (e.g. deprecation
of bindings). There's obvious overlap with several other areas of
interest (e.g. describing non-probable system topologies, ARM SoC
organisation), and it would be extremely useful to have devicetree
maintainers present as part of these discussions.

Thanks,
Mark.
