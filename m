From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 18 Nov 2014 21:23:09 +0530
Subject: [PATCH] ARM: davinci: Remove redundant casts
In-Reply-To: <54468558.8040204@cogentembedded.com>
References: <1413903211-3143-1-git-send-email-linux@rasmusvillemoes.dk>
 <54468558.8040204@cogentembedded.com>
Message-ID: <546B6B65.4050005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 October 2014 09:40 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 10/21/2014 06:53 PM, Rasmus Villemoes wrote:
> 
>> These casts to char* are unnecessary and slightly confusing, since
>> both operands actually have type const char*.
> 
>    Both operands of what? Typecast only has 1 operand. :-)

Queuing this with this description:

"
Remove unnecessary casts to char*. Both operands of the
assignment actually have type const char*.
"

Thanks,
Sekhar
