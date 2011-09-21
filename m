From: wmb@firmworks.com (Mitch Bradley)
Date: Tue, 20 Sep 2011 21:11:18 -1000
Subject: [PATCH 0/3] GIC OF bindings
In-Reply-To: <20110921.012158.2252182592946972727.davem@davemloft.net>
References: <20110920.224910.1996429830782124690.davem@davemloft.net>
	<CACxGe6t7Mdr+w+aGFPM2-FEAQaYHuG8Za9dybLgMo-5-whLyNQ@mail.gmail.com>
	<4E796EE4.6070704@firmworks.com>
	<20110921.012158.2252182592946972727.davem@davemloft.net>
Message-ID: <4E798E16.6060308@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/20/2011 7:21 PM, David Miller wrote:
> From: Mitch Bradley<wmb@firmworks.com>
> Date: Tue, 20 Sep 2011 18:58:12 -1000
>
>> interrupt-parent has been part of the interrupt mapping spec from the
>> inception of same.
>>
>> http://www.openfirmware.info/docs/rec.intmap.d09.pdf
>
> Thanks for the link.
>
> In my vast collection of Sun OF dumps, I cannot find a single instance
> where they've made use of this property, which is why I've never seen
> it before.

I can't say I'm surprised at that.  Sun hardware tends to be rather more 
hierarchical than is the norm in, for example, the PC space.  This 
particular document came into being during the CHRP era, when IBM and 
Apple were trying to glue a Macintosh legacy I/O system onto the side of 
a PC legacy I/O system.  The result was not pretty.

Sun had at least the semblance of a coherent architectural design and 
review process.
