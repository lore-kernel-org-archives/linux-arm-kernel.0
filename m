From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Apr 2012 08:43:57 +0000
Subject: [PATCH v4 01/12] ARM: OMAP2+: declare file-local functions as
 static
In-Reply-To: <20120411003516.27059.99477.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
 <20120411003516.27059.99477.stgit@dusk>
Message-ID: <201204110843.57548.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 April 2012, Paul Walmsley wrote:
> Several function declarations used only in the files in which they're
> declared should include the static keyboard, but don't:
					^^^ ???

The patch looks good otherwise,

Acked-by: Arnd Bergmann <arnd@arndb.de>
