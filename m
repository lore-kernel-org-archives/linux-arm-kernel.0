From: rob@landley.net (Rob Landley)
Date: Sat, 05 May 2012 13:44:20 -0500
Subject: [PATCH RESEND] Documentation: devicetree: Fix value format
 description
In-Reply-To: <1336217886-27224-1-git-send-email-stigge@antcom.de>
References: <1336217886-27224-1-git-send-email-stigge@antcom.de>
Message-ID: <4FA57504.2070308@landley.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2012 06:38 AM, Roland Stigge wrote:
> Numeric values in dts files can be specified in decimal and hex (the latter
> prefixed 0x). The current documentation is updated with this patch to prevent
> confusion about what is meant with values without "0x" (previously hex, now
> dec).

This updates the documentation to consistently say 0x in front of hex
values, but doesn't change the device tree _parser_. What did the parser
previously do with this input?

> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Rob Landley <rob@landley.net>

Should I track this one, or is Grant taking it in the device device tree
tree?

Rob
-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.
