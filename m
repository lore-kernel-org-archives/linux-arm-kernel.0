From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 21 Mar 2014 18:32:00 +0300
Subject: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for
 R8A7790
In-Reply-To: <1395397968-6242-7-git-send-email-phil.edworthy@renesas.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
 <1395397968-6242-7-git-send-email-phil.edworthy@renesas.com>
Message-ID: <532C5B70.5060509@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/21/2014 01:32 PM, Phil Edworthy wrote:

> This patch adds the device tree nodes for R8A7790

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>   arch/arm/boot/dts/r8a7790.dtsi | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)

    Why are you not enabling PCIe for Lager, only on Koelsch?

WBR, Sergei
