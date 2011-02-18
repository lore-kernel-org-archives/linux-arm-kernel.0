From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 18 Feb 2011 12:48:30 +0530
Subject: [PATCH v2 02/13] da850: pruss platform specific additions.
In-Reply-To: <4D5582D1.9040005@mvista.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-3-git-send-email-subhasish@mistralsolutions.com>
	<4D5582D1.9040005@mvista.com>
Message-ID: <6C4C94BAB9814DDB9D0500AF2BA1A319@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--------------------------------------------------
From: "Sergei Shtylyov" <sshtylyov@mvista.com>
Sent: Saturday, February 12, 2011 12:11 AM
To: "Subhasish Ghosh" <subhasish@mistralsolutions.com>
Cc: <davinci-linux-open-source@linux.davincidsp.com>; 
<linux-arm-kernel@lists.infradead.org>; <m-watkins@ti.com>; 
<nsekhar@ti.com>; <sachi@mistralsolutions.com>; "Kevin Hilman (supporter:TI 
DAVINCI MACHIN...,commit_signer:16/18=89%)" <khilman@deeprootsystems.com>; 
"Russell King (maintainer:ARM PORT)" <linux@arm.linux.org.uk>; "Michael 
Williamson (commit_signer:5/18=28%)" <michael.williamson@criticallink.com>; 
"Cyril Chemparathy (commit_signer:3/18=17%)" <cyril@ti.com>; "Sergei 
Shtylyov (commit_signer:3/18=17%)" <sshtylyov@ru.mvista.com>; "open list" 
<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/13] da850: pruss platform specific additions.

> Hello.
>
> Subhasish Ghosh wrote:
>
>> This patch adds the platform device and assignes the platform resources
>> for the PRUSS mfd driver.
>
>    You also add the PRUSS clock (and I would have done that as a separate 
> patch).
>
>> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
>
>    You should have noted the patch dependency here -- this patch depends 
> on the one nenaming DA8XX_LPSC0_DMAX.

SG - Will do
>
> WBR, Sergei 
