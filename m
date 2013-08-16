From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Fri, 16 Aug 2013 09:43:19 +0100
Subject: [RFC PATCH 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
In-Reply-To: <1376628601.4255.138.camel@pasglop>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376628601.4255.138.camel@pasglop>
Message-ID: <520DE627.2080007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/08/13 05:50, Benjamin Herrenschmidt wrote:
> On Thu, 2013-08-15 at 18:09 +0100, Sudeep KarkadaNagesha wrote:
>>                /* Check for ibm,ppc-interrupt-server#s. If it doesn't exist
>>                  * fallback to "reg" property and assume no threads
>>                  */
>> -
> 
> Oh and I forgot ... that comment is now wrong, since your code handles
> threads in the "reg" case...
> 
I have fixed it in the next patch while adding the documentation to
these function. I wanted changes in this patch minimal. I can fix it
here too if you insist on it.

Regards,
Sudeep
