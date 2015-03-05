From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 5 Mar 2015 01:48:01 +0100
Subject: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <1423088075-10025-4-git-send-email-marek@goldelico.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
Message-ID: <20150305004801.GC1033@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 04, 2015 at 11:14:32PM +0100, Marek Belisko wrote:
> + - volt-to-capacity-charging-map : list of voltage(mV):level(%) values
> +	for charging calibration (see example)
> + - volt-to-capacity-discharging-map : list of voltage(mV):level(%) values
> +	for discharging calibration (see example)

Please prefix these properties with "ti,"

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150305/a03a99da/attachment.sig>
