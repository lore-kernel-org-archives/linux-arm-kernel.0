From: davem@redhat.com (David Miller)
Date: Tue, 01 Jul 2014 15:38:06 -0700 (PDT)
Subject: [PATCH v2 0/2] ARM: at91: remove phy fixup for sama5d3xek boards
In-Reply-To: <1403777615-25685-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1403777615-25685-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140701.153806.1074873302413556163.davem@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Date: Thu, 26 Jun 2014 12:13:33 +0200

> This patch removes a board specific hook for sama5d3xek boards from the
> sama5d3 generic DT board file.
> 
> This hook (which register a phy fixup configuring board specific delays
> in the ksz9021 ethernet phy) is now replaced by the appropriate DT
> properties definitions in the sama5d3xcm.dtsi file.
> 
> Changes since v1:
>  - fix txc-skew-ps and rxc-skew-ps delays
>  - remove phy address info to handle Ronetix and Embest HW designs

These patches do not apply cleanly to 'net' nor 'net-next', in fact
you did not even say which tree these changes are targetting.

Please respin these patches and explicitly say what tree you wish
them to be applied to.

Thanks.
