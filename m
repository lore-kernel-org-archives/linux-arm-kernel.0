From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Nov 2014 23:54:36 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <546FCE3A.1000005@codeaurora.org>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk>
 <546FCE3A.1000005@codeaurora.org>
Message-ID: <20141121235436.GQ3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 03:43:54PM -0800, Stephen Boyd wrote:

> This sleep set/active set stuff has to do with more than just
> regulators. It applies to any resource that the RPM provides, but
> regulators are a primary use case so you're on Cc and it would be great
> if you fully understood the regulator aspect here.

Step back: what is the RPM?  Some kind of power management coprocessor
from the sounds of it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/52c6136a/attachment.sig>
