From: khilman@ti.com (Kevin Hilman)
Date: Wed, 01 Feb 2012 09:37:39 -0800
Subject: [PATCH] ARM: OMAP2+: PM debug: fix the use of debugfs_create_* API
In-Reply-To: <1328085451-23225-1-git-send-email-j-pihet@ti.com> (Jean Pihet's
 message of "Wed, 1 Feb 2012 09:37:31 +0100")
References: <1328008819-1110-1-git-send-email-j-pihet@ti.com>
 <1328085451-23225-1-git-send-email-j-pihet@ti.com>
Message-ID: <87k446fo9o.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Check the return code pointer value from debugfs_create_dir for error
> or NULL.
> Also added an additional check to prevent the creation of a 'suspend'
> entry at the debugfs root in case a power domain directory cannot be
> created.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Thanks, queing for v3.4.

Kevin
