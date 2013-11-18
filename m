From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Nov 2013 17:38:24 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <528A4F5F.7080104@jonmasters.org>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <3371903.8j54vrCjEN@wuerfel>
 <CAOesGMiYyOcvr3Aqs-p8zc=XDwJM9NZtNxtxrTZssc6F=siZCw@mail.gmail.com>
 <201311180945.52764.arnd@arndb.de> <528A4F5F.7080104@jonmasters.org>
Message-ID: <20131118173823.GJ16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 12:33:19PM -0500, Jon Masters wrote:
> In the server space we *never* ship updated ACPI tables in Red Hat
> products, and we never would ship updated tables as part of the OS.
> Platform data is platform data. It belongs to the vendor shipping the
> system, never to the OS. Yes, there are workarounds for bugs but on the
> whole you do in fact count on server vendors not to screw it up, and if
> they do then it is up to them to ship a BIOS update for their hardware.

... which is why my nightly autoboot tests regularly fail if I undock
and redock the laptop, and forget to manually rebind the serial port...
because the vendor supplied ACPI tables seem to be broken, and there's
zero interest from the vendor to fix such an issue.

They're certainly not going to fix it based on one report from an
end user using an obscure operating system which seems not to have
any support in mainline for such oeprations in any case.

Linux sucks sometimes - it's not all roses.
