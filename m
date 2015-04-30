From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 30 Apr 2015 17:25:22 +0200
Subject: [PATCH 0/3] power: reset: BCM63xx reboot support
In-Reply-To: <55369C34.5020201@broadcom.com>
References: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
 <55369C34.5020201@broadcom.com>
Message-ID: <20150430152522.GB6133@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 21, 2015 at 11:51:32AM -0700, Florian Fainelli wrote:
> On 24/03/15 17:17, Florian Fainelli wrote:
> > Hi all,
> > 
> > This patch series adds support for the BCM6328-style software reset hardware
> > block commonly found on Broadcom BCM63xx DSL SoCs.
> 
> Looks like we can utilize the generic syscon reboot driver instead of
> open-coding one, let's do that instead.

Thanks, that's preferred.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150430/9bfc27ed/attachment.sig>
