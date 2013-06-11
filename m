From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Jun 2013 12:50:21 +0100
Subject: [PATCH 08/10] regulator: ab8500-ext: Register as a device in its
 own right
In-Reply-To: <1370621488-18130-9-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
 <1370621488-18130-9-git-send-email-lee.jones@linaro.org>
Message-ID: <20130611115021.GZ1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 05:11:26PM +0100, Lee Jones wrote:
> Some platforms don't support the AB8500 external regulators, so instead
> of having a list of is_<platform>() calls prior to calling
> ab8500_ext_regulator_init() from ab8500_regulator_probe(), we can only
> register as a platform device on platforms which require them. It means
> we also have more control over them when booting with Device Tree.

Applied the rest of these, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130611/eb643c34/attachment.sig>
