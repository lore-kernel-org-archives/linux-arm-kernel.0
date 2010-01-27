From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Jan 2010 20:45:10 +0000
Subject: [Rev2]Samsung: New driver for AC97 controllers
In-Reply-To: <1264571815-14893-1-git-send-email-jassisinghbrar@gmail.com>
References: <1264571815-14893-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <20100127204510.GB11601@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 02:56:55PM +0900, jassisinghbrar at gmail.com wrote:

>  A machine driver, for SMDKs with wm9713 as AC97 codec attached, has also
> been added. The driver is generic enough to be used as such with newer SoCs.

OK, works for me with a smoke test so I've applied all the sound/soc
parts.  I'll add a commit detailing the CFG jumper settings expected to
make it work out of the box on SMDK6410 since that catches quite a few
people out.
