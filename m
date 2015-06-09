From: eric@anholt.net (Eric Anholt)
Date: Mon, 08 Jun 2015 17:03:05 -0700
Subject: [PATCH v3 1/7] dt/bindings: Add binding for the Raspberry Pi
 clock provider
In-Reply-To: <1433807940-15328-1-git-send-email-eric@anholt.net>
References: <1433807940-15328-1-git-send-email-eric@anholt.net>
Message-ID: <877frdague.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> The hardware clocks are not controllable by the ARM, so we have to
> make requests to the firmware to do so from the VPU side.  This will
> let us replace fixed clocks in our DT with actual clock control (and
> correct frequency information).
>
> v2: Include the dt-bindings header in this commit instead of the next
>     one.  Make the clock indices match the firmware clock IDs.  Rename
>     the binding's compat string.  Move the firmware phandle to be
>     under a vendor-specific namespace.

Having failed to move the versioning bits below --- again, I'm adding
scripting to hopefully catch myself if I'm about to do it again.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150608/a70f351f/attachment.sig>
