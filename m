From: cjb@laptop.org (Chris Ball)
Date: Mon, 30 Jan 2012 10:30:42 -0500
Subject: [PATCH 1/1] of_mmc_spi: fix little endian support
In-Reply-To: <CACxGe6vY5Es4S_2Q1KWVyHitOuee8XekarGBuxjuJNDbAQrtHA@mail.gmail.com>
 (Grant Likely's message of "Mon, 30 Jan 2012 08:18:08 -0700")
References: <1327896929-16274-1-git-send-email-plagnioj@jcrosoft.com>
 <20120130131430.GA28397@ponder.secretlab.ca>
 <CACxGe6vY5Es4S_2Q1KWVyHitOuee8XekarGBuxjuJNDbAQrtHA@mail.gmail.com>
Message-ID: <m239axcin1.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 30 2012, Grant Likely wrote:
> On Mon, Jan 30, 2012 at 6:14 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Mon, Jan 30, 2012 at 05:15:29AM +0100, Jean-Christophe
>> PLAGNIOL-VILLARD wrote:
>>> the voltage_ranges is supposed to switch from big endian to little endian
>>>
>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>> Cc: Grant Likely <grant.likely@secretlab.ca>
>>> Cc: linux-mmc at vger.kernel.org
>>
>> Applied, thanks.
>
> Actually, this one should go via Chris' tree since it is part of
> drivers/mmc.  So I've dropped it from my tree and change that s-o-b of
> mine to an a-b.

Thanks, done that, and removed the extra/incorrect punctuation change
from the patch.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
