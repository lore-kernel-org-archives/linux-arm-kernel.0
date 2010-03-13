From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 13 Mar 2010 08:45:46 +0000
Subject: [PATCH 05/10] ARM: ftrace: add ENDPROC annotations
In-Reply-To: <1268462987-8271-6-git-send-email-rabin@rab.in>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
	<1268462987-8271-6-git-send-email-rabin@rab.in>
Message-ID: <20100313084546.GA30400@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 13, 2010 at 12:19:42PM +0530, Rabin Vincent wrote:
>  
>  	.globl ftrace_stub
> -ftrace_stub:
> +ENTRY(ftrace_stub)

ENTRY does the .globl for you, so please kill your own version.
