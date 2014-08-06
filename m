From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 6 Aug 2014 10:09:25 -0500
Subject: [Regression] FEC: Panic on suspend in 3.16
In-Reply-To: <53E24147.4050304@parkeon.com>
References: <53E24147.4050304@parkeon.com>
Message-ID: <53E24525.2020809@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2014 09:52 AM, Martin Fuzzey wrote:
> Hi all,
> 
> I am using the fec ethernet driver on a i.MX53 SoC.
> 
> All was working fine on 3.13 but, after upgrading to 3.16 I now get a
> panic on suspend:

Same issue reported here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/277728.html

a71e3c37960c (net: phy: Set the driver when registering an MDIO bus
device) has been implicated; try reverting that.
