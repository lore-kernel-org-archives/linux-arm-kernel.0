From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 08 May 2014 13:05:22 +0200
Subject: [PATCH v10 00/15] ARM: sunxi: Add driver for SD/MMC hosts found
 on Allwinner sunxi SoCs
In-Reply-To: <20140506170437.5739.402@quantum>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <20140506170437.5739.402@quantum>
Message-ID: <536B64F2.3010901@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/06/2014 07:04 PM, Mike Turquette wrote:
> Quoting Hans de Goede (2014-05-02 08:57:14)
>> The first 2 patches are depenencies which should go in through the clk tree,
>> Mike can you pick these 2 up please ?  :
> 
> Taken into clk-next.

Thanks!

>> "clk: sunxi: factors: automatic reparenting support"
>> Is uncontroversial and has been favorably reviewed by various people.
>>
>> "clk: sunxi: Implement MMC phase control"
>> Is somewhat more controversial as there has been lots of discussion about
>> adding a generic phase control method to the clk framework. The problem is
>> that there has been a lot of talk about such a generic phase control method
>> but not a single patch. Therefor I would like to move forwards with using
>> a platform specific method for now. I hereby promise that once we've a generic
>> method I'll write patches to convert the sunxi code to that method.
> 
> Thanks for the promise. I will hold you to it once the set_phase api is
> sorted ;-)

Hehe, no problem when I promise something I expect to be kept to it.

Regards,

Hans
