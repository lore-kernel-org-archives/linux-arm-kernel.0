From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Oct 2013 16:39:36 -0700
Subject: [PATCH 2/2] ARM: dts: N900: TWL4030 Keypad Matrix definition
In-Reply-To: <1381353447-32708-2-git-send-email-sre@debian.org>
References: <1381353447-32708-1-git-send-email-sre@debian.org>
 <1381353447-32708-2-git-send-email-sre@debian.org>
Message-ID: <20131011233935.GF29913@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@debian.org> [131009 14:26]:
> Add Keyboard Matrix information to N900's DTS file.
> This patch maps the keys exactly as the original
> board code.

This should be queued by Benoit along with other .dts
changes, not via the input tree:

Acked-by: Tony Lindgren <tony@atomide.com>
