From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 09 Apr 2013 09:53:58 +0200
Subject: [PATCH] ARM i.MX53: remove platform ahci support
In-Reply-To: <20130409065916.GY1906@pengutronix.de>
References: <1365431039.1830.102.camel@x61.thuisdomein>
 <1365450363-6582-1-git-send-email-s.hauer@pengutronix.de>
 <1365451383.1830.135.camel@x61.thuisdomein>
 <20130409065916.GY1906@pengutronix.de>
Message-ID: <1365494038.1830.145.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-04-09 at 08:59 +0200, Sascha Hauer wrote:
> I wanted to say that the patch could be extended with more cleanup.

I see. But as long as long as I can't convince myself that, say, some
Kconfig symbol really is unused, it's hard for me to actually suggest
the related cleaning up. Especially when I'm touching code that I know
nothing about (as I do in most of the cleanups I suggest).


Paul Bolle
