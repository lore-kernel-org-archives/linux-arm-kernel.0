From: filip.matijevic.pz@gmail.com (=?UTF-8?Q?Filip_Matijevi=c4=87?=)
Date: Thu, 26 Oct 2017 08:25:02 +0200
Subject: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
In-Reply-To: <20171025203459.GA22035@amd>
References: <20171025203459.GA22035@amd>
Message-ID: <3dbb966f-c279-2c57-d3c2-98ca7c04accd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On 10/25/2017 10:34 PM, Pavel Machek wrote:
> 3.5.3-nemo kernel seems to work

I did take a quick look at the board-rm680.c since there are some
conditional statements with regards to system revision but I didn't
notice anything that might prevent it from booting.

> If you have
> any ideas, let me know.

Last time I couldn't get output on serial I used CONFIG_DEBUG_LL,
CONFIG_DEBUG_OMAP3UART3, CONFIG_EARLY_PRINTK... and ignore_loglevel
earlyprintk kernel params to get output early enough - I guess you
already tried that.

Regards,
Filip
