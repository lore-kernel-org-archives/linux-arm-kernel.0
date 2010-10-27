From: jason.wessel@windriver.com (Jason Wessel)
Date: Wed, 27 Oct 2010 06:58:19 -0500
Subject: [PATCH] kgdb,arm: fix register dump
In-Reply-To: <1288115392-23383-1-git-send-email-rabin@rab.in>
References: <1288115392-23383-1-git-send-email-rabin@rab.in>
Message-ID: <4CC813DB.4090001@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2010 12:49 PM, Rabin Vincent wrote:
> DBG_MAX_REG_NUM incorrectly had the number of indices in the GDB regs
> array rather than the number of registers, leading to an oops when the
> "rd" command is used in KDB.
>
>   

Thanks!

I have queued this to be merged in 2.6.37.

Cheers,
Jason.
