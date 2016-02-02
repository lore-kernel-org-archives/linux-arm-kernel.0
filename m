From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 2 Feb 2016 16:12:40 +0100
Subject: [PATCH 01/11] irqchip: sun4i: fix compilation outside of arch/arm
In-Reply-To: <1454348370-3816-2-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-2-git-send-email-andre.przywara@arm.com>
Message-ID: <56B0C768.3020805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/16 18:39, Andre Przywara wrote:
> The Allwinner sunxi specific interrupt controller cannot be compiled
> for any architecture except arm:

s/arm/arm64
