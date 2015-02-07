From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 07 Feb 2015 14:16:06 +0100
Subject: [PATCH v3 2/5] ARM: dts: pxa: add clocks
In-Reply-To: <54D60B79.5060206@cogentembedded.com> (Sergei Shtylyov's message
 of "Sat, 07 Feb 2015 15:56:25 +0300")
References: <1423312760-15871-1-git-send-email-robert.jarzmik@free.fr>
 <1423312760-15871-2-git-send-email-robert.jarzmik@free.fr>
 <54D60B79.5060206@cogentembedded.com>
Message-ID: <87a90p9815.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> writes:

> Hello.
>
> On 2/7/2015 3:39 PM, Robert Jarzmik wrote:
>> +		stuart: uart at 40700000 {
>> +			clocks = <&pxa2xx_clks CLK_STUART>;
>> +		};
>> +
>
>    The ePAPR standard tells to call such nodes "serial", not "uart".
Good to know, but not for this patch.

The naming is coming from pxa2xx.dtsi. And you're very welcome to post a patch
to fix that ;)

Cheers.

-- 
Robert
