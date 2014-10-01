From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 1 Oct 2014 21:24:44 +0200
Subject: [PATCH 1/2] mtd: m25p80: get rid of spi_get_device_id
In-Reply-To: <20141001184303.GX1193@ld-irv-0074>
References: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
 <20141001182003.GB17974@sirena.org.uk>
 <20141001184303.GX1193@ld-irv-0074>
Message-ID: <CACna6ry0TWgjfjDbAxVndrJFUu3HJe-U_HtayPruqDF6b51UGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 October 2014 20:43, Brian Norris <computersforpeace@gmail.com> wrote:
> On Wed, Oct 01, 2014 at 07:20:03PM +0100, Mark Brown wrote:
>> On Mon, Sep 29, 2014 at 11:47:53AM +0200, Rafa? Mi?ecki wrote:
>> > This simplifies the way we use spi_nor framework and will allow us to
>> > drop spi_nor_match_id.
>>
>> Please don't CC linux-spi on spi-nor patches that don't have SPI level
>> changes, it just clogs up patchwork.
>
> +1 from me. I appreciate the converse, as I don't need unrelated noise
> on linux-mtd.
>
> (I feel sorry for people over at linux-arm-kernel and devicetree, since
> they get CC'd on a large variety of unrelated things, it seems. I'm sure
> the firehose gets to be almost as bad as LKML sometimes.)

Sorry, I usually don't. AFAIR this time I copied receivers list from
the original Ben patch / discussion about auto loading.

-- 
Rafa?
