From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Sun, 11 Jun 2017 00:55:33 +0300
Subject: [PATCH v8 17/34] [media] add Omnivision OV5640 sensor driver
In-Reply-To: <1496860453-6282-18-git-send-email-steve_longerbeam@mentor.com>
References: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
 <1496860453-6282-18-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170610215532.GU1019@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Wed, Jun 07, 2017 at 11:33:56AM -0700, Steve Longerbeam wrote:
...
> +/*
> + * FIXME: remove this when a subdev API becomes available
> + * to set the MIPI CSI-2 virtual channel.
> + */
> +static unsigned int virtual_channel;
> +module_param(virtual_channel, int, 0);
> +MODULE_PARM_DESC(virtual_channel,
> +		 "MIPI CSI-2 virtual channel (0..3), default 0");

If this works for you it's a good workaround. I hope we can address the
matter properly soon --- it's related to data types, embedded data etc.

For the patch:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
