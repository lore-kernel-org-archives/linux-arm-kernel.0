From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Thu, 31 Jul 2014 06:07:01 +0200
Subject: [PATCH repost] ARM: shmobile: sh73a0: Remove spurious 0x from
 SCIFB clock name
In-Reply-To: <20140731004246.GA31860@verge.net.au>
References: <cover.1406766463.git.horms+renesas@verge.net.au>
 <20140731004246.GA31860@verge.net.au>
Message-ID: <53D9C0E5.7040301@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 31.07.2014 02:42, schrieb Simon Horman:
> A stray '0x' crept into a0f7e7496d56ac2d ("ARM: shmobile: sh73a0: add CMT1
> clock support for DT"). This  patch removes it.
> 
> This change should not have any run-time affect at this time as

"effect", in case Olof wants to fix it up.

> the clock in question is used by a SCIF device that is not enabled by
> default.
> 
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
