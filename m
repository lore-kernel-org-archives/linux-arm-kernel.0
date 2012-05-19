From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 19 May 2012 15:03:50 -0600
Subject: [PATCH RESEND] Documentation: devicetree: Fix value format
 description
In-Reply-To: <1337200436-26528-1-git-send-email-stigge@antcom.de>
References: <1337200436-26528-1-git-send-email-stigge@antcom.de>
Message-ID: <20120519210350.3E7303E03B8@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 May 2012 22:33:55 +0200, Roland Stigge <stigge@antcom.de> wrote:
> Numeric values in dts files can be specified in decimal and hex (the latter
> prefixed 0x). The current documentation is updated with this patch to prevent
> confusion about what is meant with values without "0x" (previously hex, now
> dec).
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: Rob Landley <rob@landley.net>

Applied, thanks.

g.
