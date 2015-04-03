From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 10:47:57 -0700
Subject: [PATCH] ARM: at91: add a Kconfig dependency on multi-platform
In-Reply-To: <1427987277-29462-1-git-send-email-nicolas.ferre@atmel.com>
References: <4695444.mEPNvRWLFJ@wuerfel>
 <1427987277-29462-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150403174757.GB23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 05:07:57PM +0200, Nicolas Ferre wrote:
> When building a legacy (non-multi) platforms and if the ARCH_AT91 config option
> is enabled there is a build error. We need AT91 to depend on multi-platform
> core type options.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied, thanks.


-Olof
