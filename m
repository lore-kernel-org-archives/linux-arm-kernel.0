From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 3 Sep 2018 14:58:52 +0200
Subject: [PATCH v5 0/9] ata: ahci_platform: support allwinner R40 AHCI
In-Reply-To: <20180903124229.rchurusvt4rv5ln7@flea>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
 <20180903124229.rchurusvt4rv5ln7@flea>
Message-ID: <34c6fda4-c266-8aff-e685-e6a6ee2c7890@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03-09-18 14:42, Maxime Ripard wrote:
> On Mon, Sep 03, 2018 at 12:01:52PM +0200, Corentin Labbe wrote:
>> This patchset add support for allwinner R40 AHCI controller.
>>
>> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
>> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
>> by this serie, so no regression should come with it.
>>
>> Patchs 1-7 should go via the ata tree
>> Patchs 8,9 should go via the sunxi tree
>>
> 
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

The entire series looks good to me too:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
