From: steveb@workware.net.au (Steve Bennett)
Date: Tue, 23 Mar 2010 18:37:36 +1000
Subject: [PATCH] USB: gadget: pxa25x: support additional IXP425 steppings
In-Reply-To: <20100323093009.ms6zgeh5w44k40g4@v1539.ncsrv.de>
References: <7FC3F153-EB1C-42AC-A5D7-119BCCB8C237@workware.net.au>
	<20100323093009.ms6zgeh5w44k40g4@v1539.ncsrv.de>
Message-ID: <5EB8CA3A-5EB4-4F98-B83F-5B1228CCD73C@workware.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/2010, at 6:30 PM, Hendrik Sattler wrote:

> Zitat von Steve Bennett <steveb@workware.net.au>:
> 
>> Here is a trivial patch to add support pxa25x_udc for additional IXP
>> steppings.
>> 
>> Please let me know if I should send this anywhere else/instead.
> 
> Your patch really is not the right approach.
> 
> I had a similar patch some time ago[1]. This driver part should actually be reworked to not use that ifdef and switch-case thing (and not read the cpu id register itself, either).
> 
> [1]: http://www.spinics.net/lists/arm-kernel/msg62009.html
> 
> I am not up-to-date how far Russell got with his proposed changes.
> 
> HS

Thanks. I see Russell's proposed patch at http://www.spinics.net/lists/arm-kernel/msg63303.html

Doesn't look like this got any further. It's been a year now (which is why I missed this thread).

Russell, is there something stopping us going with your patch?
Does it just need some updating/testing?

Cheers,
Steve
--
?Web: Embedded Web Framework - http://uweb.workware.net.au/
