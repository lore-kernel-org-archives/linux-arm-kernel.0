From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 12:55:02 +0200
Subject: [GIT PULL] mailbox driver framework for v3.10 merge window
In-Reply-To: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com>
References: <37C860A02101E749A747FA2D3C1E3C504A1971@DLEE11.ent.ti.com>
Message-ID: <201304091255.03020.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013, Anna, Suman wrote:
> OMAP and ST-Ericsson platforms are both using mailbox to communicate with some coprocessors. This series creates a consolidated framework, living under drivers/mailbox.
> The changes mainly contain:
> - create a mailbox framework independent from OMAP h/w
> - creates dbx500 mailbox driver for ST-Ericsson platforms
> - move the omap mailbox out of plat-omap/mach-omapX  adapting to the new framework.
> - minor bug fixes in mailbox code

Pulled into a new next/mailbox branch, to keep it separate from the
existing subsystems.

As a note for you: when you send a pull request, please make sure that you
use a tag that includes the changeset text (your description above), so I
don't have to copy it from the email. I noticed that you do have a tag
"mailbox-for-v3.10" in your tree, but the pull request was for the branch
with the same contents.

	Arnd
