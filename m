From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 21 Feb 2018 20:59:59 +0100
Subject: [PATCH 1/2] ARM: shmobile: Factor out complex condition
In-Reply-To: <20180219085837.tsza3xakwxodrwko@verge.net.au>
References: <20180217020642.21375-1-marek.vasut+renesas@gmail.com>
 <20180219085837.tsza3xakwxodrwko@verge.net.au>
Message-ID: <b51178de-26f3-45fb-18a8-52a5ba91f153@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2018 09:58 AM, Simon Horman wrote:
> On Sat, Feb 17, 2018 at 03:06:41AM +0100, Marek Vasut wrote:
>> Pull the complex condition in regulator_quirk_notify() into
>> regulator_quirk_check(). Moreover, do not hard-code the I2C
>> address, but rather use the one in da9xxx_msgs[].
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> There appears to be some review of this series that needs addressing,
> I have marked it as "Changes Requested".
> 
Jupp

-- 
Best regards,
Marek Vasut
