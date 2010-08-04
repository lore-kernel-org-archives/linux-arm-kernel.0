From: ben@simtec.co.uk (Ben Dooks)
Date: Wed, 04 Aug 2010 16:16:47 +0100
Subject: S5PC110 should be used the correct VIC number
In-Reply-To: <AANLkTikh7mt30gEQU0_Wr7n-jZrG0iUmd1Hw17Ni7UNQ@mail.gmail.com>
References: <AANLkTikh7mt30gEQU0_Wr7n-jZrG0iUmd1Hw17Ni7UNQ@mail.gmail.com>
Message-ID: <4C59845F.7060909@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/07/10 11:54, Kyungmin Park wrote:
> Hi Ben,
> 
> Can you post the VIC patch from correct VIC number from vic code at
> suspend & resume?
> If not, it has to modify it after release. or can you fix it as below.

I'll check to see if the patch I sent a while back to
dynamically allocate these and thus remove the need
to use the Kconfig to configure it.

-- 
Ben
