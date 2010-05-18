From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 18 May 2010 19:46:27 +0100
Subject: [RFC PATCH 0/3] ep93xx i2s audio
In-Reply-To: <4BF21B67.8090404@bluewatersys.com>
References: <4BF21B67.8090404@bluewatersys.com>
Message-ID: <20100518184627.GF22554@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 04:45:27PM +1200, Ryan Mallon wrote:

>  - Sometimes playback (ie aplay) results in noise. Killing the process
> and trying again will result in correct playback.

What does the output data look like in a scope, is it bit shifted
relative to the clocks for example?
