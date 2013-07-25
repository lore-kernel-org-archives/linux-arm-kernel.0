From: broonie@kernel.org (Mark Brown)
Date: Thu, 25 Jul 2013 20:30:42 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <CAOesGMiLKysW2JG1jbef76Ves=-DAYEiE9d+s8YXWRXUJ+XhaQ@mail.gmail.com>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <CAOesGMiLKysW2JG1jbef76Ves=-DAYEiE9d+s8YXWRXUJ+XhaQ@mail.gmail.com>
Message-ID: <20130725193042.GS9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 11:25:30AM -0700, Olof Johansson wrote:

> To talk semi-specifics: What about USB PHY tunings for a specific
> board, where each of the three USB ports and their registers have
> slightly different layout? Sure, we can take 10 properties to describe
> each tunable field in each register, but at the end it will just be
> used to craft the contents blindly, so we might just stuff the 32-bit
> register value as a property instead. And in other cases we might
> indeed want to describe each property independently. Determining what
> is appropriate when is one of the most difficult parts of the review
> workflow.

There's also my constant question about why the driver can't just work
out the right value or decide to use the feature autonomously at runtime
- I'd say that the overwhelming proportion of properties I push back on
end up just getting removed and worked out automatically.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/506c2a35/attachment.sig>
