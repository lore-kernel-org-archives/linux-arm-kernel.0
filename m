From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 21 Feb 2018 12:35:35 -0800
Subject: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
In-Reply-To: <20180221171349.GG29204@lunn.ch>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180221171349.GG29204@lunn.ch>
Message-ID: <4afd2fec-b015-72d4-300e-3dd7696f6ff0@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/21/2018 9:13 AM, Andrew Lunn wrote:
> On Wed, Feb 21, 2018 at 08:16:00AM -0800, Jae Hyun Yoo wrote:
>> This commit adds a dt-bindings document of PECI adapter driver for Aspeed
>> AST24xx/25xx SoCs.
> 
> Hi Jae
> 
> It would be good to separate this into two. One binding document for a
> generic adaptor, with a generic PECI bus, and generic client
> devices. List all the properties you expect at the generic level.
> 
> Then have an aspeed specific binding for those properties which are
> specific to the Aspeed adaptor.
> 

That makes sense. I'll add generic PECI bus/adapter/client and Aspeed 
specific documents as separated.

> 	 Andrew
>   
> 

Thanks again for sharing your time to review it. I really appreciate it.

BR,
Jae
