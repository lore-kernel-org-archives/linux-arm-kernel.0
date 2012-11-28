From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 27 Nov 2012 23:03:32 -0800
Subject: [PATCH 3/3] Input: bu21013_ts - Add support for Device Tree
 booting
In-Reply-To: <1354021990-16978-4-git-send-email-lee.jones@linaro.org>
References: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
 <1354021990-16978-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20121128070332.GC23378@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Nov 27, 2012 at 01:13:10PM +0000, Lee Jones wrote:
> Now we can register the BU21013_ts touch screen when booting with
> Device Tree enabled. Here we parse all the necessary components
> previously expected to be passed from platform data.

I applied these 3 patches, but for DT we also need to specify compatible
ID and set up of_match_table pointer. Please send me a follow-up patches
doing that and also describing DT bindings for BU21013.

Thanks.

-- 
Dmitry
