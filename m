From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 07 Feb 2015 20:30:38 +0300
Subject: [PATCH v3 2/5] ARM: dts: pxa: add clocks
In-Reply-To: <87a90p9815.fsf@free.fr>
References: <1423312760-15871-1-git-send-email-robert.jarzmik@free.fr>	<1423312760-15871-2-git-send-email-robert.jarzmik@free.fr>	<54D60B79.5060206@cogentembedded.com>
 <87a90p9815.fsf@free.fr>
Message-ID: <54D64BBE.9080704@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/07/2015 04:16 PM, Robert Jarzmik wrote:

>>> +		stuart: uart at 40700000 {
>>> +			clocks = <&pxa2xx_clks CLK_STUART>;
>>> +		};
>>> +

>>     The ePAPR standard tells to call such nodes "serial", not "uart".

> Good to know, but not for this patch.

> The naming is coming from pxa2xx.dtsi.

    Ah, I was wondering why the node descriptions included only one prop.

 > And you're very welcome to post a patch to fix that ;)

    In my copious free time... :-)

> Cheers.

WBR, Sergei
