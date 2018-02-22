From: haiyue.wang@linux.intel.com (Wang, Haiyue)
Date: Thu, 22 Feb 2018 16:50:17 +0800
Subject: [PATCH] MAINTAINERS: Update ASPEED entry with details
In-Reply-To: <1519288786.101739.1279390200.1CD3EC51@webmail.messagingengine.com>
References: <20180222050324.21531-1-joel@jms.id.au>
 <1519288786.101739.1279390200.1CD3EC51@webmail.messagingengine.com>
Message-ID: <23b668f1-ab4b-7ef3-ba1e-f252fbba4d1b@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew & Joel,

Since you are ASPEED BMC experts, any time and interest in eSPI code 
review ? I've sent

it before, but no more response. Intel recommends eSPI bus than LPC as I 
know. I just kept

the minimal eSPI code which is approved to work well in our real server 
boards for two more

years. Other part of eSPI driver from ASPEED's SDK? has been removed, 
because ePSI is a new

thing, we only use a small feature set like booting host.

We Intel submit this eSPI patch for openbmc upstreaming, hope for your 
response. :-)

https://patchwork.kernel.org/patch/10166577/



On 2018-02-22 16:39, Andrew Jeffery wrote:
>
> On Thu, 22 Feb 2018, at 15:33, Joel Stanley wrote:
>> I am interested in all ASPEED drivers, and the previous match wasn't
>> grabbing files in nested directories. Use N instead.
>>
>> Add the arm kernel mailing list so that patches get reviewed there, and
>> the linux-aspeed list which exists only so I can use patchwork to track
>> patches.
>>
>> Add Andrew as a reviewer, because he is involved in reviewing ASPEED
>> stuff.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>
