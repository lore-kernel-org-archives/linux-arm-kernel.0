From: broonie@kernel.org (Mark Brown)
Date: Thu, 28 Jun 2018 11:14:55 +0100
Subject: [PATCH v2] driver core: add a debugfs entry to show deferred
 devices
In-Reply-To: <20180627220656.19298-1-javierm@redhat.com>
References: <20180627220656.19298-1-javierm@redhat.com>
Message-ID: <20180628101455.GB14040@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 12:06:56AM +0200, Javier Martinez Canillas wrote:
> With Device Trees (DT), the dependencies of the devices are defined in the
> DT, then the drivers parse that information to lookup the needed resources
> that have as dependencies.

Reviewed-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180628/8d09f999/attachment.sig>
