From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Jul 2014 17:39:23 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140702100133.GE18731@arm.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk>
 <20140702100133.GE18731@arm.com>
Message-ID: <20140702163923.GJ410@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 11:01:33AM +0100, Will Deacon wrote:

>   (1) The hardware doesn't have the instruction at all. If we start
>       emulating it, then we'll always have to emulate it and it doesn't
>       encourage software migration.

That's what the logging other architectures did in similar situations
was intended to help address - even if people don't care about the
performance impact having loud complaints in the logs tends to cause
some useful subset of users to report it as a problem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140702/e4f13bf2/attachment.sig>
