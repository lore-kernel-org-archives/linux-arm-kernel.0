From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 00:18:45 +0000
Subject: [PATCH 37/46] regulator: ab8500-ext: Adapt regulator
 registration for newly changed API
In-Reply-To: <1363881583-15234-38-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
 <1363881583-15234-38-git-send-email-lee.jones@linaro.org>
Message-ID: <20130328001845.GQ18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 03:59:34PM +0000, Lee Jones wrote:
> From: Gabriel Fernandez <gabriel.fernandez@stericsson.com>
> 
> Instead of using a long list of arguments for registering a new
> regulator, the API has changed to accommodate a new structure
> which is to contain the necessary runtime configuration. This
> patch allows the external regulator to follow suit and continue
> to successfully register itself with the Regulator subsystem.

This really ought to be squashed in to the earlier commits which won't
compile without this fix...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130328/b8fa5b2a/attachment.sig>
