From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 31 Aug 2012 16:41:05 +0200
Subject: [PATCH 7/8] ARM: dts: add twi nodes for atmel SOCs
In-Reply-To: <1346405077-18620-1-git-send-email-ludovic.desroches@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
 <1346405077-18620-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20120831144105.GB23867@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:24 Fri 31 Aug     , ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Add twi nodes for atmel SOCs and remove i2c-gpio ones.
Only drop the i2c-gpio on the soc that are kn own to have no issue on the hw
IP. For hte onther one keep both in the dtsi

Best Regards,
J.
