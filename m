From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 13 Jan 2013 15:43:48 -0500
Subject: [PATCH v2] mmc: mvsdio: Replace IS_ERR_OR_NULL() with IS_ERR()
In-Reply-To: <1357889273-11553-1-git-send-email-andrew@lunn.ch>
References: <20130111004323.GA12257@schnuecks.de>
 <1357889273-11553-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130113204348.GR13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 08:27:52AM +0100, Andrew Lunn wrote:
> A NULL is a valid clk cookie, so we should not be tested with
> IS_ERR_OR_NULL(). Replace it with IS_ERR().
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> This patch depends on Thomas Petazzoni DT patches for mvsdio, which changed
> the order of resource allocation etc.

grrr, I'm seeing fixes depending on features :(  Any way to avoid that?

In light of Russell's comments, shall I wait for a v3?  All of Thomas'
mvsdio work is now waiting on this.  I'd like to get that in as early as
possible.

thx,

Jason.
