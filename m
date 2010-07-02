From: ben@simtec.co.uk (Ben Dooks)
Date: Fri, 02 Jul 2010 10:38:38 +0100
Subject: [PATCH 30/33] Removing dead S3C_DEV_ADC
In-Reply-To: <7baaebb4983ce9482e3f83ca42240b864157cb79.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<7baaebb4983ce9482e3f83ca42240b864157cb79.1277911346.git.siccegge@cs.fau.de>
Message-ID: <4C2DB39E.8050600@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/06/10 17:03, Christoph Egger wrote:
> S3C_DEV_ADC doesn't exist in Kconfig, therefore removing all
> references for it from the source code.

This is going to be fixed in the next kernel release, one way
or the other, so please drop this patch

-- 
Ben
