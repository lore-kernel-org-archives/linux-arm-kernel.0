From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Jan 2014 11:03:03 +0000
Subject: [PATCH 3/3] Binding: atmel-wm8904: add option to choose clock
In-Reply-To: <52D736E0.90207@atmel.com>
References: <1389669956-2304-1-git-send-email-voice.shen@atmel.com>
 <1389669956-2304-4-git-send-email-voice.shen@atmel.com>
 <20140115115417.GA9558@ns203013.ovh.net> <52D736E0.90207@atmel.com>
Message-ID: <20140116110303.GN15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 09:33:20AM +0800, Bo Shen wrote:
> On 01/15/2014 07:54 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:

> >>  Optional properties:
> >>    - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
> >>+  - clk_from_rk_pin: according to hardware design, clk privide on rk pin
> >							  provide

> >	?? no example?

> If this patch set is acceptable. The sama5 audio will use it (I will
> send patch after this patch set). Do I still need to put the example
> in the binding document?

It doesn't seem terribly worthwhile to have the example include every
boolean property, it's not like people should find it hard to work out
how to use them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140116/4accd138/attachment.sig>
