From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 9 Dec 2010 16:49:56 +0100
Subject: [PATCH 11/20] mfd/tc3589x: fix random interrupt misses
In-Reply-To: <1291388753-14662-12-git-send-email-sundar.iyer@stericsson.com>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
	<1291388753-14662-12-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <20101209154956.GV8884@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sundar,

On Fri, Dec 03, 2010 at 08:35:44PM +0530, Sundar Iyer wrote:
> On the TC35892, a random delayed interrupt clear (GPIO IC) write locks up the
> child interrupts. In such a case, the original interrupt is active and not yet
> acknowledged. Re-check the IRQST bit for any pending interrupts and handle
> those.

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

That does look like this patch should go into 2.6.37. Could you please
generate it against Linus tree and send it to me ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
