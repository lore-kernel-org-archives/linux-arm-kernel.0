From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 15:37:34 +0000
Subject: [PATCH 03/11] ASoC: ux500: Provide better checking for Device
 Tree and/or Platform Data
In-Reply-To: <1387468508-12286-4-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20140107153734.GL31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 03:55:00PM +0000, Lee Jones wrote:
> These drivers will not work without platform specific data, which is
> passed in via Device Tree or Platform Data. To avoid the chance of
> NULL pointer dereferencing and alike, let's ensure we have at least
> one of the methods in play before continuing.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/a92cc9d1/attachment-0001.sig>
