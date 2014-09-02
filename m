From: broonie@kernel.org (Mark Brown)
Date: Tue, 2 Sep 2014 16:22:28 +0100
Subject: [PATCH] ARM: configs: Remove REGULATOR_VIRTUAL_CONSUMER from
 defconfigs
In-Reply-To: <5405DD72.30603@wwwdotorg.org>
References: <1409486590-23645-1-git-send-email-broonie@kernel.org>
 <5405DD72.30603@wwwdotorg.org>
Message-ID: <20140902152228.GW29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 09:08:34AM -0600, Stephen Warren wrote:
> On 08/31/2014 06:03 AM, Mark Brown wrote:

> >The virtual consumer is a test device intended to be used while developing
> >regulator drivers, it should never be used in production. Remove it from
> >all defconfigs to avoid confusion among users.

> tegra_defconfig isn't a distro configuration, and has plenty of other
> debug/test options turned on. I'm not sure that removing this option really
> has much benefit. Still, this likely isn't going to cause any issue, so I
> guess it's fine. People can always add the option locally if they want.

In order to instantiate it you're going to have to generate a custom DT
anyway so I don't think the burden is excessive.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140902/5e47a30d/attachment-0001.sig>
