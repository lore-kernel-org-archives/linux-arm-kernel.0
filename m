From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Tue, 18 May 2010 12:52:13 +0900
Subject: [PATCH] serial: SAMSUNG: Fix dev_name and driver_name
In-Reply-To: <20100518024820.GK27571@trinity.fluff.org>
References: <4BF13ABA.3090504@samsung.com>
	<20100518024820.GK27571@trinity.fluff.org>
Message-ID: <4BF20EED.5040306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/18/2010 11:48 AM, Ben Dooks wrote:
> On Mon, May 17, 2010 at 09:46:50PM +0900, Joonyoung Shim wrote:
>> Thd dev_name and driver_name should be switched each other.
> 
> Hmm, this doesn't seem to have appeard on the linux-arm-kernel list yet.
>  
> Please provide some information about what problem that this is fixing
> and the impact on any existing systems.
> 

The serial device nodes are created to s3c2410_serial* on android 
platform instead of ttySAC*.
