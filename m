From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 28 Jul 2013 17:35:46 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <CAKON4OzReTRb5JnJE+07vNJ-uDndLfqq8ha04J7K3x=WtsZEWw@mail.gmail.com>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1416484.XDfk5G56BI@flatron> <20130728131901.GA8864@netboy>
 <2529481.u8xHuXumcd@flatron>
 <CAKON4OzReTRb5JnJE+07vNJ-uDndLfqq8ha04J7K3x=WtsZEWw@mail.gmail.com>
Message-ID: <20130728153546.GB5224@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 28, 2013 at 10:09:57AM -0400, jonsmirl at gmail.com wrote:
> 
> 3.z kernel is free to alter the schema. But it will have to supply the
> necessary quirks needed to keep those old dtb's functioning.

The quirks idea sounds okay to me, if it can really provide forward
compatibility. In practice, I doubt anyone will really spend the
effort to make this work. I think it would be much easier to make sure
the bindings are "future proof" in the first place.

Thanks,
Richard
