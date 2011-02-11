From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 11 Feb 2011 21:41:21 +0300
Subject: [PATCH v2 02/13] da850: pruss platform specific additions.
In-Reply-To: <1297435892-28278-3-git-send-email-subhasish@mistralsolutions.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-3-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D5582D1.9040005@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Subhasish Ghosh wrote:

> This patch adds the platform device and assignes the platform resources
> for the PRUSS mfd driver.

    You also add the PRUSS clock (and I would have done that as a separate patch).

> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>

    You should have noted the patch dependency here -- this patch depends on the 
one nenaming DA8XX_LPSC0_DMAX.

WBR, Sergei
