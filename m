From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 May 2014 18:06:04 -0700
Subject: [PATCH v5 4/8] input: misc: Add driver for AXP20x Power Enable Key
In-Reply-To: <1398947374-3115-5-git-send-email-carlo@caione.org>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-5-git-send-email-carlo@caione.org>
Message-ID: <20140503010604.GE4090@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 01, 2014 at 02:29:30PM +0200, Carlo Caione wrote:
> This patch add support for the Power Enable Key found on MFD AXP202 and
> AXP209. Besides the basic support for the button, the driver adds two
> entries in sysfs to configure the time delay for power on/off.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140502/8fe6d50c/attachment.sig>
