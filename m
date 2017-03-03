From: corbet@lwn.net (Jonathan Corbet)
Date: Fri, 3 Mar 2017 15:46:50 -0700
Subject: [PATCH v2 09/17] Documentation: kernel-parameters: Document owl
 earlycon
In-Reply-To: <20170224034055.18807-10-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-10-afaerber@suse.de>
Message-ID: <20170303154650.4d959227@lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Feb 2017 04:40:47 +0100
Andreas F?rber <afaerber@suse.de> wrote:

> +		owl,<addr>
> +			Start an early, polled-mode console on an Owl serial
> +			port at the specified address. The serial port must
> +			already be setup and configured. Options are not yet
> +			supported.
> +

Apologies, I'm just getting around to looking at this.

Is there any chance of getting a version of it that (1) has a proper
changelog, and (2) better describes the applicability of this option.
Presumably if I don't know what an "Owl serial port" is I don't need it,
but maybe a phrase saying where such ports might be found would be helpful
here?

Thanks,

jon
