From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Jul 2016 20:21:29 +0200
Subject: [PATCH 4/4] ARM: dts: sun8i: Add dts file for the Orange Pi Lite
 SBC
In-Reply-To: <1468095718-18515-4-git-send-email-hdegoede@redhat.com>
References: <1468095718-18515-1-git-send-email-hdegoede@redhat.com>
 <1468095718-18515-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20160728182129.GB26326@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jul 09, 2016 at 10:21:58PM +0200, Hans de Goede wrote:
> +	aliases {
> +		/* The H3 emac is not used so the wifi is ethernet0 */
> +		ethernet1 = &rtl8189ftv;

There's a mismatch between your comment and what you did here.

The rest is fine though.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160728/94f42fe9/attachment.sig>
