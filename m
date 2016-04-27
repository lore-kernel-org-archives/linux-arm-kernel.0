From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Apr 2016 11:32:28 +0100
Subject: [PATCH] regulator: axp20x: Fix LDO4 linear voltage range
In-Reply-To: <f63acd04-33ed-02d6-0ce4-b9c436a3bf84@redhat.com>
References: <1461679251-25538-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v648p8T5PqxZTyvoZsugcTM03-mqjNnwSZLXJq_KnErFdA@mail.gmail.com>
 <20160426145735.GX3217@sirena.org.uk>
 <f63acd04-33ed-02d6-0ce4-b9c436a3bf84@redhat.com>
Message-ID: <20160427103228.GI3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 11:46:29AM +0200, Hans de Goede wrote:
> On 26-04-16 16:57, Mark Brown wrote:

> >I have no record of any such patch, I don't know where it might've been
> >sent.

> It is here:

Please follow the normal submission workflow, don't pick random new
places to send things.  It's fine to copy extra places but if you don't
send to the normal places your patches are likely to not be seen.

> https://groups.google.com/forum/#!topic/linux-sunxi/3sjt47-CtbU

That's linux-sunxi and linux-arm-kernel but not linux-kernel where
regulator patches are supposed to be sent.  I did go look to see if I
could see anything on lkml but there was nothing visible from you.

> And according to that archive it was send to broonie at linaro.org
> (amongst others).

That's my work address, not broonie at kernel.org which is the address I
use consistently and which is what is advertised in MAINTAINERS.  That
goes somewhere completely different which isn't set up to handle patches
and since essentialy everything that does manage to get sent there is
also sent to the right place things sent there tend to get deleted
unread when I'm doing inbox triage which I imagine is what happened
here.  This is the one that's most critical.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/8e8d939d/attachment.sig>
