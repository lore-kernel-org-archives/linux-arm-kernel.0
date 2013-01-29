From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Jan 2013 16:28:53 +0100
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <20130129152518.GZ23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129161211.7bb8cada@skate>
 <20130129151501.GY23505@n2100.arm.linux.org.uk>
 <20130129162337.0121cbab@skate>
 <20130129152518.GZ23505@n2100.arm.linux.org.uk>
Message-ID: <20130129162853.58dc14d7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Tue, 29 Jan 2013 15:25:18 +0000, Russell King - ARM Linux wrote:

> Yep, otherwise we'll have yet more code to review rather than one
> algorithm with a set of numbers...
> 
> I work on the principle that if something can be expressed numerically,
> that's always better than expressing it with code.

Having a hook allows for more flexibility (for example having special
alignment requirements depending on the device or something like that),
but I don't need this flexibility for the specific case I'm interested
in. So as you suggest, let's not over-engineer this, and use numerical
values. I'll rework my patch according to this suggestion.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
