From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 11 Apr 2012 12:16:11 -0600 (MDT)
Subject: [PATCH v4 01/12] ARM: OMAP2+: declare file-local functions as
 static
In-Reply-To: <201204110843.57548.arnd@arndb.de>
References: <20120411003454.27059.37500.stgit@dusk>
 <20120411003516.27059.99477.stgit@dusk> <201204110843.57548.arnd@arndb.de>
Message-ID: <alpine.DEB.2.00.1204111215480.29473@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Apr 2012, Arnd Bergmann wrote:

> On Wednesday 11 April 2012, Paul Walmsley wrote:
> > Several function declarations used only in the files in which they're
> > declared should include the static keyboard, but don't:
> 					^^^ ???

Heh, should have read "keyword".

> The patch looks good otherwise,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the comment, ack added.

- Paul
