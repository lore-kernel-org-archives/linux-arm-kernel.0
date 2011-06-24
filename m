From: khilman@ti.com (Kevin Hilman)
Date: Fri, 24 Jun 2011 15:29:22 -0700
Subject: [PATCH v3 09/12] OMAP3: Serial: Remove uart pads from 3430 board
	file.
In-Reply-To: <1307532194-13039-10-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Wed, 8 Jun 2011 16:53:11 +0530")
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-10-git-send-email-govindraj.raja@ti.com>
Message-ID: <8739iyx3r1.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> The pad values here are same as the default pad values updated in
> serial.c file.
> Avoid structure duplication and use default pads.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

This should be folded in with [03/12]

Kevin
