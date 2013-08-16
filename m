From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 16 Aug 2013 14:50:01 +1000
Subject: [RFC PATCH 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
In-Reply-To: <1376586580-5409-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1376628601.4255.138.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-08-15 at 18:09 +0100, Sudeep KarkadaNagesha wrote:
>                /* Check for ibm,ppc-interrupt-server#s. If it doesn't exist
>                  * fallback to "reg" property and assume no threads
>                  */
> -

Oh and I forgot ... that comment is now wrong, since your code handles
threads in the "reg" case...

Cheers,
Ben.
