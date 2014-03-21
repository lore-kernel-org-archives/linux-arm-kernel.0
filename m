From: Phil.Edworthy@renesas.com (Phil.Edworthy at renesas.com)
Date: Fri, 21 Mar 2014 15:06:48 +0000
Subject: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for
 R8A7790
In-Reply-To: <532C5B70.5060509@cogentembedded.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
 <1395397968-6242-7-git-send-email-phil.edworthy@renesas.com>
 <532C5B70.5060509@cogentembedded.com>
Message-ID: <OF1B1A84A2.0FE335EF-ON80257CA2.0052C1C4-80257CA2.005304D4@eu.necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On: 21/03/2014 14:32, Sergei wrote:
> Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes 
for R8A7790
> 
> Hello.
> 
> On 03/21/2014 01:32 PM, Phil Edworthy wrote:
> 
> > This patch adds the device tree nodes for R8A7790
> 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >   arch/arm/boot/dts/r8a7790.dtsi | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> 
>     Why are you not enabling PCIe for Lager, only on Koelsch?
The Lager board doesn't have PCIe hardware. Note that it's possible to 
modify the Lager board and convert the SATA signals to PCIe, and we've 
done that to check that it works on R-Car H2.

> WBR, Sergei
> 

Thanks
Phil
