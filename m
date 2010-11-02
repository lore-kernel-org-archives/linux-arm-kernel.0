From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 2 Nov 2010 09:25:33 -0400
Subject: ASoC: fix the building issue of missing codec field in 'struct
	snd_soc_card'
In-Reply-To: <AANLkTikc09UxEB+ZwGSF-guyTV_5FU2t9yXeagUAQoQ7@mail.gmail.com>
References: <AANLkTikc09UxEB+ZwGSF-guyTV_5FU2t9yXeagUAQoQ7@mail.gmail.com>
Message-ID: <20101102132533.GD21476@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 02, 2010 at 05:10:07AM +0800, Eric Miao wrote:

Applied but please provide a signoff and remember to CC both Liam and
alsa-devel for ASoC patches.  I've taken it without the signoff since
it's a small and obvious fix.
