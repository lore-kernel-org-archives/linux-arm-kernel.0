From: rob@landley.net (Rob Landley)
Date: Wed, 16 May 2012 20:09:17 -0500
Subject: [PATCH RESEND] Documentation: devicetree: Fix value format
 description
In-Reply-To: <1337200436-26528-1-git-send-email-stigge@antcom.de>
References: <1337200436-26528-1-git-send-email-stigge@antcom.de>
Message-ID: <4FB44FBD.1000408@landley.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2012 03:33 PM, Roland Stigge wrote:
> Numeric values in dts files can be specified in decimal and hex (the latter
> prefixed 0x). The current documentation is updated with this patch to prevent
> confusion about what is meant with values without "0x" (previously hex, now
> dec).
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: Rob Landley <rob@landley.net>

This should go in through the device tree tree. (There's policy
involved, not just documenting the status quo.)

Rob
-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.
