From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 26 May 2010 00:18:32 +0100
Subject: [patch 0/5] kirkwood openrd client audio support - v3
In-Reply-To: <20100525122236.841941526@mandriva.com>
References: <20100525122236.841941526@mandriva.com>
Message-ID: <20100525231831.GA11785@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 02:22:36PM +0200, apatard at mandriva.com wrote:

> It's a new try to get merged kirkwood openrd client support.

> The changes are :
> - set window configuration according to dma address
> - namespaced all cs42l51 #define
> - modified cs42l51_dac_names array according to what proposed Mark Brown
> - use SOC_DOUBLE_TLV for mic boost

This looks mostly OK to me - I had a few comments on the CODEC driver
but they're fairly minor.  It'd be good to get some input from the
Kirkwood guys, particularly with regard to the merge path here.
