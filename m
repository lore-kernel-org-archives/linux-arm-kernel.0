From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Fri, 24 Jun 2011 09:37:03 +0200
Subject: [PATCH 23/25] ARM: pm: omap34xx: convert to generic
	suspend/resume support
In-Reply-To: <E1QZpOS-0005nt-Fq@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
	<E1QZpOS-0005nt-Fq@rmk-PC.arm.linux.org.uk>
Message-ID: <BANLkTim2ZL8vV9TUofCdq5F=pbFheHQ=Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Just a minor remark:
On Thu, Jun 23, 2011 at 9:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Convert sa11x0 to use the generic CPU suspend/resume support, rather
               ^^^^^^^ should be 'OMAP3'
> than implementing its own version. ?Tested on 3430 LDP.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Jean
