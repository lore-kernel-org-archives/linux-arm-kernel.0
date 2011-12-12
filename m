From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 12 Dec 2011 18:11:43 +0100
Subject: [PATCH V3] mfd: Fixed unconditional reset of the ADC reading
 enable bits
In-Reply-To: <1322564943-17872-1-git-send-email-robin@protonic.nl>
References: <1322564943-17872-1-git-send-email-robin@protonic.nl>
Message-ID: <20111212171143.GP13952@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Tue, Nov 29, 2011 at 12:09:03PM +0100, Robin van der Gracht wrote:
> When the ADC is being prepared for a single or multiple channel reading,
> the adc0 register is reconfigured without taking the lithium cell, charge
> current and battery current reading enable bits into account. Which results
> in clearing the bits.

Patch applied, thanks. Uwe, should I add your Acked-by ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
