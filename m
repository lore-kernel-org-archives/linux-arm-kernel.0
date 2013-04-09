From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 9 Apr 2013 11:05:01 +0200
Subject: [PATCH] mfd: ab8500-core: Add of_compatilbe property for
 ab8500-usb
In-Reply-To: <1365497841-4640-1-git-send-email-fabio.baltieri@linaro.org>
References: <1365497841-4640-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <20130409090501.GF23447@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Tue, Apr 09, 2013 at 10:57:21AM +0200, Fabio Baltieri wrote:
> Add of_comptabile string to the ab8500-usb cell to allow the driver to
> grab properties from device-tree when available.
> 
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
> 
> Hi Samuel,
> 
> this oneline allows the driver to grab regulators and other attributes
> from device tree.
> 
> This is actually generated on top of -next, so it should apply cleanly on
> your current mfd-next tree.  If it doesn't, I'll rebase on your updated
> tree when available.
It applies cleanly, I just pushed it now.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
