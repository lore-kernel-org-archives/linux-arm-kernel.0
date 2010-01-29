From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 29 Jan 2010 22:37:27 +0100
Subject: [PATCH v5] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
In-Reply-To: <1264799926.2975.3.camel@realization>
References: <1264799926.2975.3.camel@realization>
Message-ID: <20100129213727.GB21364@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alberto,

On Fri, Jan 29, 2010 at 10:18:46PM +0100, Alberto Panizzo wrote:
> The MXC family of Application Processors is shipped with a Keypad Port
would you mind to do s/MXC/IMX/ in your patch?  Currently both are used
but we (=Sascha and me) will try to deprecate MXC.

> + * >>Power management need to be implemented<<.
s/need/needs/ (or alternatively do it :-)  and maybe s/<<\./.<</ ?

> [...]
> +
> +	/* The matrix is stable only if no changes are detected after
> +	 * MXC_KEYPAD_SCANS_FOR_STABILITY scans */
unusual format of the comment.

	/*
	 * ...
	 * ...
	 */

is the most found way in the kernel for multi-line comments.

> [...]
> +MODULE_LICENSE("GPL v2");
There is no space expected in the string passed to MODULE_LICENSE.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
