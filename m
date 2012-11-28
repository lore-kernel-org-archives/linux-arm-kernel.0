From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Nov 2012 08:57:31 +0000
Subject: [PATCH 3/3] Input: bu21013_ts - Add support for Device Tree
 booting
In-Reply-To: <20121128070332.GC23378@core.coreip.homeip.net>
References: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
 <1354021990-16978-4-git-send-email-lee.jones@linaro.org>
 <20121128070332.GC23378@core.coreip.homeip.net>
Message-ID: <20121128085731.GH2013@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

> On Tue, Nov 27, 2012 at 01:13:10PM +0000, Lee Jones wrote:
> > Now we can register the BU21013_ts touch screen when booting with
> > Device Tree enabled. Here we parse all the necessary components
> > previously expected to be passed from platform data.
> 
> I applied these 3 patches, but for DT we also need to specify compatible
> ID and set up of_match_table pointer. 

Why do you need a compatible string?

> Please send me a follow-up patches
> doing that and also describing DT bindings for BU21013.

I'll send the documentation as a seperate reply to your email.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
