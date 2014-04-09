From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 9 Apr 2014 14:21:01 +0200
Subject: [PATCH v12][ 09/12] drm/panel: Add Eukrea mbimxsd51 displays.
In-Reply-To: <1396874691-27954-9-git-send-email-denis@eukrea.com>
References: <1396874691-27954-1-git-send-email-denis@eukrea.com>
 <1396874691-27954-9-git-send-email-denis@eukrea.com>
Message-ID: <20140409122058.GA20753@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 02:44:48PM +0200, Denis Carikli wrote:
[...]
> +static const struct panel_desc eukrea_mbimxsd51_dvisvga = {
> +	.modes = &eukrea_mbimxsd51_dvisvga_mode,
> +	.num_modes = 1,
> +	.size = {
> +		.width = 0,
> +		.height = 0,
> +	},
> +};
[...]
> +static const struct panel_desc eukrea_mbimxsd51_dvivga = {
> +	.modes = &eukrea_mbimxsd51_dvivga_mode,
> +	.num_modes = 1,
> +	.size = {
> +		.width = 0,
> +		.height = 0,
> +	},
> +};

Surely these two panels have a physical size?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140409/1168cba1/attachment-0001.sig>
