From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 May 2014 11:40:53 +0200
Subject: [PATCH 1/2] ARM: dts: sun7i: cubietruck: set mmc3 bus-width
 property
In-Reply-To: <1400694211-29903-1-git-send-email-hdegoede@redhat.com>
References: <1400694211-29903-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140522094053.GA27329@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 07:43:30PM +0200, Hans de Goede wrote:
> bus-width defaults to 1, and all 4 lines are hooked up at the cubietruck,
> properly set bus-width to 4.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Merged the two patches, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140522/9988e7a9/attachment.sig>
