From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 9 Dec 2010 16:45:51 +0100
Subject: [PATCH 08/20] mfd/tc3589x: rename tc35892 structs/registers to
	tc359x
In-Reply-To: <1291388753-14662-9-git-send-email-sundar.iyer@stericsson.com>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
	<1291388753-14662-9-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <20101209154550.GT8884@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sundar,

On Fri, Dec 03, 2010 at 08:35:41PM +0530, Sundar Iyer wrote:
> Most of the register layout, client IRQ numbers on the TC35892 is shared also
> by other variants. Make this generic as tc3589x

I suppose board-mop500.c is the only tc35892 user ? I couldn't find any other
piece of code using it, I just want to double check.
If that's the case then:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
