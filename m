From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Jun 2017 15:00:00 +0200
Subject: [PATCH v5 0/7] ARM: Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <2ac09633-cfa8-f941-dc35-4e903b2b8a13@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
 <4e7625ec-54cd-899f-39a7-7cf0c2c8cb26@arm.com>
 <20170608162555.GP4902@n2100.armlinux.org.uk>
 <e9ab0dd0-17e5-b124-6637-3651fea86713@arm.com>
 <2ac09633-cfa8-f941-dc35-4e903b2b8a13@arm.com>
Message-ID: <20170620125959.GA29060@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 01:59:10PM +0100, Vladimir Murzin wrote:
> +Christoph since he is trying to consolidate work in this area [1].
> 
> Christoph, any chance you can look into patches touching
> dma-{coherent,noop}.c?
> 
> [1] https://patchwork.ozlabs.org/patch/778254/

Sure, will do.
