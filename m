From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 21 Sep 2015 16:51:09 +0100
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56001B78.2090001@free.fr> (Mason's message of "Mon, 21 Sep 2015
 17:00:08 +0200")
References: <56001B78.2090001@free.fr>
Message-ID: <yw1xeghrsrde.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> 1) Linux kernel runs in non-secure world. The port used to tweak
> L2 cache configuration via custom SMC calls to the OS running in
> secure world. I've removed that for now.
> Is there a standard solution these days?

It is generally preferred to have the boot loader perform such
configuration whenever possible.

-- 
M?ns Rullg?rd
mans at mansr.com
