From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 18 Nov 2009 09:30:33 -0800
Subject: [PATCH 1/4] input: atmel_tsadcc: touchscreen rework setting
	capabilities
In-Reply-To: <693b9933de6fe9eb7e4401ca56a8f9ab6a966666.1258553002.git.nicolas.ferre@atmel.com>
References: <693b9933de6fe9eb7e4401ca56a8f9ab6a966666.1258553002.git.nicolas.ferre@atmel.com>
Message-ID: <20091118173033.GA4385@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, Nov 18, 2009 at 03:12:12PM +0100, Nicolas Ferre wrote:
> Tiny patch for setting capabilities using input API function.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

All looks good. Since the series span platform and input subtrees how do
you want to merge it?

-- 
Dmitry
