From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Nov 2013 19:40:22 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <201311211926.03228.arnd@arndb.de>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <201311181605.37300.arnd@arndb.de>
 <20131121161037.C528CC406A3@trevor.secretlab.ca>
 <201311211926.03228.arnd@arndb.de>
Message-ID: <20131121194022.GA14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 07:26:02PM +0100, Arnd Bergmann wrote:

> + A number of subsystems that Intel needs to handle on embedded systems
>   should really not be described in detail on servers on any architecture
>   but instead be handled in AML or SMBIOS (e.g. pinctrl or phy).

Are we 100% sure about this assumption?  We're saying "server" here but
how much of that is really "distro" - if it is distro then you start to
get things like laptops coming into play which do have a lot more of the
fun stuff that we see on embedded devices in active use.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131121/2b2de12c/attachment.sig>
