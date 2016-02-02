From: robh@kernel.org (Rob Herring)
Date: Tue, 2 Feb 2016 15:20:15 -0600
Subject: [PATCH 04/10] Documentation: dt-bindings: Add a new compatible
 for the Armada 3700
In-Reply-To: <1454436468-4241-5-git-send-email-gregory.clement@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160202212015.GA21364@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 07:07:42PM +0100, Gregory CLEMENT wrote:
> The AHCI interfaces used in the Armada 3700 has a few differences with
> the one used in the Armada 38x, so it deserves its own compatible string.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
