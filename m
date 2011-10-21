From: andi@firstfloor.org (Andi Kleen)
Date: Fri, 21 Oct 2011 19:03:39 +0200
Subject: [PATCH 2/3] ARM: Add static kernel function stack size analyzer,
	for ARM
In-Reply-To: <1861853.vLiqXrnQg4@wuerfel>
References: <4E9E0B71.9020708@am.sony.com> <4E9E0C66.3020405@am.sony.com>
	<1861853.vLiqXrnQg4@wuerfel>
Message-ID: <20111021170339.GA22535@one.firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> I thought we now had a gcc option for this. gcc documentation points to -Wstack-usage=XXX.
> This was first introduced on s390 in architecture specific gcc code, but should now work
> everywhere.

CONFIG_FRAME_WARN=...

Has been there forever for any architecture.

-Andi
