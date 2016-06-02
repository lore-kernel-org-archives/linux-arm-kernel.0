From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 3 Jun 2016 00:34:26 +0300
Subject: [PATCH 12/13] ARM: dts: blanche: initial device tree
In-Reply-To: <20160601012153.GK20527@verge.net.au>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <1923946.Jvi0TDUXFC@wasted.cogentembedded.com>
 <20160601012153.GK20527@verge.net.au>
Message-ID: <149347f1-f636-cd65-6c6d-509f7c3306f0@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 04:21 AM, Simon Horman wrote:

>> Add the initial device  tree for the R8A7792 SoC based Blanche board.
>> The board has 2 debug serial ports: SCIF0 and SCIF3; include support for
>> them,  so that  the serial console  can  work.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> At this time I do not have access to documentation or hardware for this
> board. So I am relying on you to test this and make sure it complies
> with the spec.

    Don't worry, the patches have been tested on the real hardware.

> What you have looks reasonable to me:
>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

    Thank you. :-)

MBR, Sergei
