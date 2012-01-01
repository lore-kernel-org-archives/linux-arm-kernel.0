From: robherring2@gmail.com (Rob Herring)
Date: Sun, 01 Jan 2012 09:51:31 -0600
Subject: Renaming MACH_TYPE_KINETIS_K60 into MACH_TYPE_KINETIS
In-Reply-To: <1325069504.1584.160.camel@skywanderer.emcraft.com>
References: <1325065882.1584.153.camel@skywanderer.emcraft.com>
 <201112281100.35209.marek.vasut@gmail.com>
 <1325069504.1584.160.camel@skywanderer.emcraft.com>
Message-ID: <4F008103.9090001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/2011 04:51 AM, Alexander Potashev wrote:
> On Wed, 2011-12-28 at 11:00 +0100, Marek Vasut wrote:
>> If you use FDT, you won't need machine ID at all. 
> 
> Hi Marek,
> 
> You are right, but we have not used FDT for any of our ARM Linux ports
> yet (consistency matters.) If we switch to FDT now, a lot of code will
> need to be rewritten.

Not if you are only talking about the machine identification. You need a
minimal dts file with a compatible string for the board and add this
string to your machine desc.

DT is a requirement for adding any new ARM platform.

Rob
