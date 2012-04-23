From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Apr 2012 09:26:22 -0600
Subject: [PATCHv3 1/2] drivers: input: keypad: Add device tree support
In-Reply-To: <1335194839-30193-1-git-send-email-sourav.poddar@ti.com>
References: <1335194839-30193-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <4F95749E.40708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2012 09:27 AM, Sourav Poddar wrote:
> Update the Documentation with omap4 keypad device tree
> binding information.
> Add device tree support for omap4 keypad driver.

Shouldn't this use the already-defined matrix keyboard bindings at
Documentation/devicetree/bindings/input/matrix-keymap.txt?

(I asked this before, but don't recall seeing any response explaining
why a new binding was needed. Sorry if I missed it.)
