From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 00:16:43 +0000
Subject: [PATCH 28/46] regulator: ab8500: Delete useless fixed_uV field
In-Reply-To: <1363881583-15234-29-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
 <1363881583-15234-29-git-send-email-lee.jones@linaro.org>
Message-ID: <20130328001643.GP18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 03:59:25PM +0000, Lee Jones wrote:
> From: Mustapha Ben Zoubeir <mustapha.ben.zoubeir-nonst@stericsson.com>
> 
> The fixed_uV property residing in ab8500_ext_regulator_info is
> currently unused. We remove it here.

This is definitely a bugfix to an earlier commit in the series, can we
please have these squashed into the original commits?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130328/63d48f86/attachment-0001.sig>
