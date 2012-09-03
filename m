From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Sep 2012 15:55:56 -0400
Subject: [PATCH v2] ARM: Build dtb files in all target
In-Reply-To: <20120903122134.GA3290@linaro.org>
References: <1346303687-7795-1-git-send-email-andrew@lunn.ch>
 <20120901144922.GA25277@lunn.ch> <20120903122134.GA3290@linaro.org>
Message-ID: <20120903195556.GP19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 01:21:34PM +0100, Dave Martin wrote:
> I'll leave it for the stable guys to judge whether this patch is
> appropriate for them.  The patch itself is a feature addition, which
> would normally exclude it.  But its inclusion might still be considered
> justified on grounds of improving build regression coverage of dtbs and
> dtc on stable.

Thank you for stating this more clearly than I originally did.  This is
exactly why I thought -stable would want it.

thx,

Jason.
