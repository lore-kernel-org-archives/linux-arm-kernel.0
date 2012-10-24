From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 24 Oct 2012 22:14:10 +0200
Subject: [PATCH 1/9] ARM: Kirkwood: Convert TS219 to pinctrl.
In-Reply-To: <20121024220021.148a88ff@skate>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>	<1351090434-30499-2-git-send-email-andrew@lunn.ch>	<20121024213128.2d4c07dc@skate>	<50884659.1020208@gmail.com>
 <20121024220021.148a88ff@skate>
Message-ID: <50884C12.7050809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 10:00 PM, Thomas Petazzoni wrote:
> On Wed, 24 Oct 2012 21:49:45 +0200, Sebastian Hesselbarth wrote:
>> Now consider some more complex interface with more than one mpp pin per
>> interface pin. Do you really want to predefine all possible combinations
>> even if it is more likely that in fact only one is used on all boards
>> because they are all based on the same reference design?
>
> Where did I say that you should define *all* possible configurations?
>
> I said: "The SoC .dtsi file should define all the pinmux groups that are
> described in the datasheet and are used by boards". Read again the "and
> are used by boards".

Ok, then I overread "and used by other boards". Sorry for that.

> So I'm clearly not advocating adding *all* possible configurations,
> because there would be gazillions of them. But I'm in favor of moving
> the *used* configurations to the .dtsi files.

Agreed.

Sebastian
