From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 27 Jul 2018 07:32:15 +0200
Subject: [PATCH 6/6] ARM: spectre-v1: mitigate user accesses
In-Reply-To: <20180726132006.GY17271@n2100.armlinux.org.uk> (Russell King's
 message of "Thu, 26 Jul 2018 14:20:06 +0100")
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
 <E1fctPA-0005vT-QX@rmk-PC.armlinux.org.uk>
 <20180726124900.syqvsltidm4c2oud@lakrids.cambridge.arm.com>
 <20180726132006.GY17271@n2100.armlinux.org.uk>
Message-ID: <8736w5p7kw.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Thu, Jul 26, 2018 at 01:49:00PM +0100, Mark Rutland wrote:
>> On Tue, Jul 10, 2018 at 03:14:12PM +0100, Russell King wrote:

>> > Harden the get_user() accessors against Spectre attaacks by forcing out
Small typo: s/attaacks/attacks/

Cheers.

-- 
Robert
