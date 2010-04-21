From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Apr 2010 08:37:56 +0900
Subject: [PATCH 1/4] pxa: add namespace on ssp
In-Reply-To: <q2yf17812d71004211517kf54116acxe788927a53048e26@mail.gmail.com>
References: <n2t771cded01004162234sb67befcfp60ba67bfe1a8117f@mail.gmail.com>
	<q2yf17812d71004211517kf54116acxe788927a53048e26@mail.gmail.com>
Message-ID: <20100421233755.GA22879@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 22, 2010 at 06:17:29AM +0800, Eric Miao wrote:

> Sorry I'm still not convinced that this is a necessary change, could
> you point me to some place where there are naming conflicts?

Look at Liam's recent posting about the updated ASoC device model - that
introduces a number of incompatible API changes.
