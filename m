From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Mon, 24 Aug 2009 13:18:58 -0400
Subject: New SoC - where does it go?
Message-ID: <1251134338.5257.15.camel@jmcmullan-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm working on a Linux port for our new SoC, and I'm wondering where
everything should go.

We're using an ARM MP11 core, and I currently have everything
(SoC support and board config) in the same mach-FOO directory.

Should I split this into a plat-FOO and a mach-FOO, and if so,
what should go where?

Assume, for sake of argument (and lack of marketing names), that
the SoC is called FOO, and our eval board is called BAR.

Thanks!

- Jason McMullan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090824/ac8374d7/attachment.sig>
