From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Oct 2012 16:44:59 +0000
Subject: [GIT PULL] vexpress: soc changes for v3.8
In-Reply-To: <1350579917.4984.19.camel@hornet>
References: <1350579917.4984.19.camel@hornet>
Message-ID: <201210261645.00157.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 October 2012, Pawel Moll wrote:
>       ARM: vexpress: Start using new Versatile Express infrastructure

This patch introduces calls to vexpress_clk_of_init and other functions
that don't yet exist. Can you send a fixup?

	Arnd
