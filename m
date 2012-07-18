From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Jul 2012 15:13:58 +0000
Subject: [PATCHv3 1/1] ARM:vt8500: Convert to use .restart and remove
 arch_reset()
In-Reply-To: <1342619015.49231.YahooMailNeo@web140803.mail.bf1.yahoo.com>
References: <1342615030.5079.YahooMailNeo@web140804.mail.bf1.yahoo.com>
 <201207181259.21669.arnd@arndb.de>
 <1342619015.49231.YahooMailNeo@web140803.mail.bf1.yahoo.com>
Message-ID: <201207181513.58766.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 July 2012, Tony Prisk wrote:
> Removed system.h as it only contained an inline for arch_reset()
> Changed the existing board files to use .restart in machine descriptions.
> 
> Added device tree support for the restart controller.
> Device tree support for mach-vt8500 is still a work-in-progress.
> 
> Change History
> v3: style changes.

The change history of the patch should go below the '---'
line, there is no need to preserve that in the git changelog
in cases like this. For larger patches you may actually
want to preserve it and put it here, but the fact that you
applied style changes is not such a case ;-)

> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Acked-by: Arnd Bergmann <arnd@arndb.de>

The patch looks good, but you've sent it through a mail client
that mangles the patch into a form that I cannot apply.

Please use git-send-email or use a setup described in 
Documentation/email-clients.txt.

The preferred way would actually be a 'git request-pull'
with a public git URL, but patches are also fine
if it's only an occasional bug fix like this.

	Arnd
