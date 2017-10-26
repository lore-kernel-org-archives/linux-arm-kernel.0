From: batnnubv@gmail.com (Don Baton)
Date: Thu, 26 Oct 2017 12:56:30 +0300
Subject: [PATCH v9 04/10] arm: dts: sunxi: h3/h5: represent the mdio
 switch used by sun8i-h3-emac
In-Reply-To: <20171026095411.GJ20299@lunn.ch>
References: <20171024175714.15840-1-clabbe.montjoie@gmail.com>
 <20171024175714.15840-5-clabbe.montjoie@gmail.com>
 <20171026095411.GJ20299@lunn.ch>
Message-ID: <CACY=2cmXHQYqMdugEjrAb9gv-7pQ9mSuN4LADdyb=kPyhGnsXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-26 12:54 GMT+03:00, Andrew Lunn <andrew@lunn.ch>:
> On Tue, Oct 24, 2017 at 07:57:08PM +0200, Corentin Labbe wrote:
>> Since dwmac-sun8i could use either an integrated PHY or an external PHY
>> (which could be at same MDIO address), we need to represent this
>> selection
>> by a MDIO switch.
>>
>> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew
>
