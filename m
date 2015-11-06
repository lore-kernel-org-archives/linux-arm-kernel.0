From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Nov 2015 10:31:47 +0000
Subject: [PATCH v2 1/2] dt-bindings: sound: Add DT bindings for Broadcom
 Cygnus audio
In-Reply-To: <563BB5B0.5040501@broadcom.com>
References: <1446502284-23907-2-git-send-email-ssimran@broadcom.com>
 <20151104140746.GE1717@sirena.org.uk>
 <563BB5B0.5040501@broadcom.com>
Message-ID: <20151106103147.GZ18409@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 12:01:52PM -0800, Simran Rai wrote:
> On 11/4/2015 6:07 AM, Mark Brown wrote:
> >On Mon, Nov 02, 2015 at 02:11:23PM -0800, Simran Rai wrote:

> >>+  Interfaces grouping of serial port. In multi-channel stereo, use
> >>+  "2_0", in 3.1 multi-channel grouping, use "3_1" and in 5.1
> >>+  multi-channel grouping, use "5_1".

> >I don't really understand what this means or why this is not runtime
> >configured.

> By runtime configured, do you mean passing the channel grouping through
> machine file? Is there any specific callback that I can use?

No, this appears to just be setting the number of channels which is
normally configured depending on how many channels userspace is playing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/7d51feb6/attachment.sig>
