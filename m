From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 29 Feb 2012 17:25:02 +0200
Subject: [PATCHv3 0/4] ARM: OMAP4: core retention support
Message-ID: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes compared to previous version:

- split out the io_chain set as a separate set
- marked patch 3 as TEMP, this is only needed until Paul's pwrdm fixes
  get merged (http://marc.info/?l=linux-omap&m=133040749621183&w=2)

Depends on the io_chain set to provide wakeup capability from
retention.

Tested with omap4430 blaze : suspend / resume works okay.

-Tero
