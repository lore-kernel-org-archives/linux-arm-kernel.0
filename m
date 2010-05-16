From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 16 May 2010 18:35:23 +0100
Subject: [patch 1/6] orion/kirkwood: add audio functions.
In-Reply-To: <20100515153129.715456900@mandriva.com>
References: <20100515152958.899927802@mandriva.com>
	<20100515153129.715456900@mandriva.com>
Message-ID: <20100516173519.GE9830@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 15, 2010 at 05:29:59PM +0200, apatard at mandriva.com wrote:
> This patch add audio related definitions and functions

> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

This patch looks OK but obviously I'm not really reviewing the arch
side.  The CPU side ASoC drivers need do depend on this, though, so
the patches for that will need to go in through the same tree or do a
merge of some kind.  I don't know what the Orion maintainer's thoughts
are there?
