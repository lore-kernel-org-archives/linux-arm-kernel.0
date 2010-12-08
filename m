From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Dec 2010 14:58:01 +0000
Subject: [PATCH 2/3] ASoC: CS4271 codec support
In-Reply-To: <20101208144757.GD2716@pulham.picochip.com>
References: <1291809772.31916.4.camel@r60e>
	<20101208130720.GB2716@pulham.picochip.com>
	<20101208133935.GI16418@rakim.wolfsonmicro.main>
	<20101208144757.GD2716@pulham.picochip.com>
Message-ID: <20101208145801.GM16418@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 02:47:57PM +0000, Jamie Iles wrote:

> Ahh, thanks for the explanation, I completely misunderstood the way that the 
> codecs were selected by the arch's in sound/soc/* and assumed that they were 
> user selectable options.

They're not user selectable as you have to write explicit code to glue
the machine together - that per machine code just selects the CODEC
drivers it needs.
