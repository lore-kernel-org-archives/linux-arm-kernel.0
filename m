From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 May 2014 13:53:01 -0500
Subject: [PATCH v10 02/15] clk: sunxi: Implement MMC phase control
In-Reply-To: <1399046249-19472-3-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20140506185301.GJ9464@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Fri, May 02, 2014 at 05:57:16PM +0200, Hans de Goede wrote:
> From: Emilio L?pez <emilio@elopez.com.ar>
> 
> HdG: add header exporting clk_sunxi_mmc_phase_control
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Do you agree with Hans proposal to merge this, and then convert to the
clk_set_phase proposal whenever we will have the details of the phase
values?

Thanks,
Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140506/81ecf689/attachment.sig>
