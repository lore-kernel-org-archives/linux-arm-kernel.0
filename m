From: andi@firstfloor.org (Andi Kleen)
Date: Wed, 19 Oct 2011 07:02:11 +0200
Subject: [PATCH 0/3] ARM 4Kstacks: introduction
In-Reply-To: <20111019045418.GF21338@dastard>
References: <4E9E0B71.9020708@am.sony.com> <1318983248.7569.5.camel@Joe-Laptop>
	<4E9E1944.80601@am.sony.com> <20111019045418.GF21338@dastard>
Message-ID: <20111019050211.GF15908@one.firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> "You can't use block based storage because the storage stack doesn't
> fit in 4k."

Likely far more than that.

Perhaps a better way would be to simply put the stack into a virtual
mapping and allocate more as needed.

I agree it's a bad idea in mainline.

-Andi
