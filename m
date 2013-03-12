From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 12 Mar 2013 17:16:26 +0100
Subject: [PATCH v9 5/9] dmaengine: edma: Add TI EDMA device tree binding
In-Reply-To: <20130312160945.GX6209@beef> (Matt Porter's message of "Tue, 12
 Mar 2013 12:09:45 -0400")
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
 <1362586540-10393-6-git-send-email-mporter@ti.com>
 <90c29a73df9e495f907517c49dd45b88@DFLE72.ent.ti.com>
 <20130312160945.GX6209@beef>
Message-ID: <878v5stwyt.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Matt" == Matt Porter <mporter@ti.com> writes:

Hi,

 Matt> +edma: edma at 49000000 {
 Matt> +	reg = <0x49000000 0x10000>;
 Matt> +	interrupt-parent = <&intc>;
 Matt> +	interrupts = <12 13 14>;
 >> 
 >> Probably interrupt-parent should be removed from the example as well to
 >> match am33xx.dtsi

 Matt> On second thought, I'm not sure we're going to get any direction
 Matt> on this one so let's just do what feels right and make it reflect
 Matt> common usage like you suggested.

Sounds good to me!

-- 
Bye, Peter Korsgaard
