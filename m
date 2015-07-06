From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Jul 2015 12:21:21 +0200
Subject: [PATCH v3 2/4] mfd: axp20x: Add missing registers, and mark more
 registers volatile
In-Reply-To: <1435316357-26606-2-git-send-email-hdegoede@redhat.com>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <1435316357-26606-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150706102121.GG3269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 12:59:15PM +0200, Hans de Goede wrote:
> From: Bruno Pr?mont <bonbons@linux-vserver.org>
> 
> Add an extra set of registers which is necessary tu support the PMICs
> battery charger function, and mark registers which contain status bits,
> gpio status, and adc readings as volatile.
> 
> Cc: Bruno Pr?mont <bonbons@linux-vserver.org>
> Signed-off-by: Bruno Pr?mont <bonbons@linux-vserver.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150706/94359d35/attachment.sig>
