From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 12 Jun 2014 14:56:30 +0200
Subject: Kconfig fails: big select-based circular dependency
In-Reply-To: <20140612121806.GY5099@sirena.org.uk>
References: <20140607090944.GL23430@n2100.arm.linux.org.uk>
 <20140612094745.GD23430@n2100.arm.linux.org.uk>
 <6077426.uLBS643pC0@wuerfel>
 <20140612113445.GF23430@n2100.arm.linux.org.uk>
 <CAMuHMdV0F_FhtJwrzJLbxTbQPKs1XzR=Yb0wjMw2TBuXNPObpA@mail.gmail.com>
 <20140612121806.GY5099@sirena.org.uk>
Message-ID: <1402577790.10273.30.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-06-12 at 13:18 +0100, Mark Brown wrote:
> Architecture feature Kconfig symbols typically have the pattern that the
> architecture selects ARCH_HAS_FOO and then code that needs the feature
> depends on ARCH_HAS_FOO.

A similar usage can be seen with Kconfig symbols with a HAVE_BAR name.


Paul Bolle
