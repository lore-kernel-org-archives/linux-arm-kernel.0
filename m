From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Feb 2014 23:14:10 -0500
Subject: [PATCH 0/3] ARM: mvebu: Use preprocessor macros for Armada
 375/38x DTs
In-Reply-To: <1392894691-26837-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392894691-26837-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140222041410.GU7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 12:11:28PM +0100, Thomas Petazzoni wrote:
> Jason, Greg, Andrew, Sebastian,
> 
> Here are three small patches that slightly improve the recently merged
> Armada 375/38x DTs by using the existing preprocessor macros for
> interrupt specifiers.
> 
> Since the mvebu/dt-3xx branch is apparently not available from the
> mvebu repository, these patches are based on mvebu/for-next. I guess
> Jason can rebase them on dt-3xx when applying, or I can resend them on
> top of dt-3xx once this branch is made available publicly.
> 
> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (3):
>   ARM: mvebu: use C preprocessor include for Armada 375/38x DTs
>   ARM: mvebu: use GIC_{SPI,PPI} in Armada 375/38x DTs
>   ARM: mvebu: use macros for interrupt flags on Armada 375/38x
> 
>  arch/arm/boot/dts/armada-375.dtsi | 60 +++++++++++++++++++++------------------
>  arch/arm/boot/dts/armada-380.dtsi |  8 +++---
>  arch/arm/boot/dts/armada-385.dtsi |  8 +++---
>  arch/arm/boot/dts/armada-38x.dtsi | 46 +++++++++++++++++-------------
>  4 files changed, 67 insertions(+), 55 deletions(-)

Series applied to mvebu/dt-3xx with Gregory's Acks.

(and pushed this time as well ;-) )

thx,

Jason.
