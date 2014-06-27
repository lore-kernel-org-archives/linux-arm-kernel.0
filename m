From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 27 Jun 2014 09:53:17 +0200
Subject: [PATCH v5 03/14] clk: max77686: Add DT include for MAX77686 PMIC
 clock
In-Reply-To: <53AD21E5.1030609@suse.de>
References: <1403806546-31122-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403806546-31122-4-git-send-email-javier.martinez@collabora.co.uk>
 <53AD21E5.1030609@suse.de>
Message-ID: <53AD22ED.5040303@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On 06/27/2014 09:48 AM, Andreas F?rber wrote:
> Am 26.06.2014 20:15, schrieb Javier Martinez Canillas:
>> This patch adds a dt-binding include for Maxim 77686
>> PMIC clock IDs that can be to be shared between the
> 
> "can be shared"?
> 

As it should be quite clear right now I'm not a native English speaker. I meant
that the header file can be included by both Device Tree source files and the
max77802 driver.

> Regards,
> Andreas
> 

Best regards,
Javier
