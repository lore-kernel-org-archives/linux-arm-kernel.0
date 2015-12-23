From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Wed, 23 Dec 2015 00:37:22 -0800
Subject: [PATCH v1 1/6] dt-bindings: misc: add document for reboot-mode
 driver
In-Reply-To: <20151223003217.GA18700@rob-hp-laptop>
References: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
 <1450775124-23966-1-git-send-email-andy.yan@rock-chips.com>
 <20151223003217.GA18700@rob-hp-laptop>
Message-ID: <CAAtXAHfkfqELHamMVK3-6UE+LtVwimA7oe=QEzfF2WyrHXxcaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Tue, Dec 22, 2015 at 4:32 PM, Rob Herring <robh@kernel.org> wrote:

> I would like to see the property names here standardized as much as
> possible. I'm not sure if we can define the properties as a u32 or need
> some flexibility here.

Quick question, semi on topic. I have a similar case (and a driver in
the pipeline),
however all I got is a (persistent over reboot) hardware register to
which I can write whatever.
On the other side I'd have u-boot pull out the value, but as it's up
to u-boot to
implement whatever it does with this info I'm kinda struggling with the idea
of a standardized binding. In my case I'd like it to go into 'safe
mode' or 'firmware update'.

With loader = <0xace0ba5e>, <0xdeadbeef> ... and loader-names <> I
could have u-boot read the values
from fdt at boot. Then again I'm not describing hardware, but specific
settings ...

Would that be acceptable?

Cheers,

Moritz
