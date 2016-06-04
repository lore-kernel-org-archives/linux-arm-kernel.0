From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 4 Jun 2016 16:01:55 +0200
Subject: [PATCH v2 1/4] power: axp20x_usb: Add support for usb
 power-supply on axp22x pmics
In-Reply-To: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160604140154.GB31801@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 02, 2016 at 07:18:53PM +0200, Hans de Goede wrote:
> The usb power-supply on the axp22x pmics is mostly identical to the
> one on the axp20x pmics. One significant difference is that it cannot
> measure / monitor the usb voltage / current.

Acked-By: Sebastian Reichel <sre@kernel.org>

What's the merge strategy for this patchset?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160604/fe8bc925/attachment-0001.sig>
