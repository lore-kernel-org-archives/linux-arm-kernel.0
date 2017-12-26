From: robh@kernel.org (Rob Herring)
Date: Tue, 26 Dec 2017 16:41:35 -0600
Subject: [PATCH 13/14] input: touchscreen: sama5d2_rts: SAMA5D2 Resistive
 touchscreen driver
In-Reply-To: <1513955241-10985-14-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
 <1513955241-10985-14-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20171226224135.qzh45mnl3a7ghbfs@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 05:07:20PM +0200, Eugen Hristev wrote:
> This is the implementation of the Microchip SAMA5D2 SOC resistive
> touchscreen driver.
> The driver registers an input device and connects to the give IIO device
> from devicetree. It requires an IIO trigger (acting as a consumer) and
> three IIO channels : one for X position, one for Y position and one
> for pressure.
> It the reports the values to the input subsystem.
> 
> Some parts of this driver are based on the initial original work by
> Mohamed Jamsheeth Hajanajubudeen and Bandaru Venkateswara Swamy

This doesn't appear to have anything specific to SAMA5D2 SoC, but is 
rather just a generic ADC (IIO based) resistive touchscreen driver.

Perhaps the binding can also be just an "adc-resistive-touchscreen".

Rob
