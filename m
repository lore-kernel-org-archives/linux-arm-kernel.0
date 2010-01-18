From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 18 Jan 2010 17:56:43 +0000
Subject: [PATCH] regulator: mc13783: consider Power Gates as digital
	regulators.
In-Reply-To: <1263837004.3632.52.camel@realization>
References: <1263830523.3632.22.camel@realization>
	<20100118163212.GA32045@rakim.wolfsonmicro.main>
	<1263834473.3632.31.camel@realization>
	<20100118172002.GB6889@rakim.wolfsonmicro.main>
	<1263837004.3632.52.camel@realization>
Message-ID: <20100118175642.GA12760@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 06:50:04PM +0100, Alberto Panizzo wrote:

> Maybe I not deep explained what's going on..

Like I say, half the problem was that the first bit of code was very
opaque so by the time you got past that the reader was already likely to
be lost.
