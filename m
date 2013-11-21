From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Thu, 21 Nov 2013 17:01:22 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131121162944.F087FC406A3@trevor.secretlab.ca>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
 <20131121162944.F087FC406A3@trevor.secretlab.ca>
Message-ID: <20131121170122.GB22960@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 04:29:44PM +0000, Grant Likely wrote:

> Personally, I think the issue of ACPI support should be taken on a
> patch-by-patch basis. A lot of the things that need to be done are quite
> discrete and fairly well contained. If the patches don't look that way
> then push back on them. For the parts that look ready, go ahead and
> merge it. Push back on the ones that don't.

I think the most valuable thing in ACPI is the static data tables. 
Things like BERT, EINJ, HEST, MPST and the various other bits of RAS 
functionality have value in the ARM world, and being able to share the 
implementation is a benefit. But that can be implemented without 
worrying about using ACPI for device discovery or interfacing.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
