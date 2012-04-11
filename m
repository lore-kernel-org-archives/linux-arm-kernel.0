From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 11 Apr 2012 17:04:15 +0530
Subject: [PATCH v2 02/15] ARM: mark const init data with __initconst
 instead of __initdata
In-Reply-To: <1333137905-13809-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120330200358.GV15647@pengutronix.de>
 <1333137905-13809-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4F856C37.2040304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 3/31/2012 1:34 AM, Uwe Kleine-K?nig wrote:
> As long as there is no other non-const variable marked __initdata in the
> same compilation unit it doesn't hurt. If there were one however
> compilation would fail with
> 
> 	error: $variablename causes a section type conflict
> 
> because a section containing const variables is marked read only and so
> cannot contain non-const variables.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

For the DaVinci parts,

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
