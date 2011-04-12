From: arend@broadcom.com (Arend van Spriel)
Date: Tue, 12 Apr 2011 15:18:55 +0200
Subject: [RFC][PATCH] axi: add AXI bus driver
In-Reply-To: <BANLkTi=jV12tOR_=idn0z+oO_RQ2xaFhCQ@mail.gmail.com>
References: <1302566227-23788-1-git-send-email-zajec5@gmail.com>
	<BANLkTi=jV12tOR_=idn0z+oO_RQ2xaFhCQ@mail.gmail.com>
Message-ID: <op.vtttxt083ri7v4@arend-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2011 15:04:48 +0200, Rafa? Mi?ecki <zajec5@gmail.com> wrote:

> There is one more change I started to consider. Is "core" correct name
> for AXI's device? Almost everywhere we can read about *components* on
> the AXI interconnect.
>
> Maybe it'd make sense to s/core/comp/? Arend?

I have no strong preference on this. I tried the latest patch and it does  
not crash anymore with load/unload.

Gr. AvS
-- 
"The world is indeed comic, but the joke is on mankind." ? H.P. Lovecraft
