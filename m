From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 4 May 2010 11:27:32 +0100
Subject: [PATCH 2/2] regulator: use array in 88pm860x
In-Reply-To: <k2q771cded01005040022l59571796yde4d0480bd048d74@mail.gmail.com>
References: <k2q771cded01005040022l59571796yde4d0480bd048d74@mail.gmail.com>
Message-ID: <20100504102732.GC15454@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 03:22:40AM -0400, Haojian Zhuang wrote:
> From a76bf9c3342babff2bff788651c09f54604b505d Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Tue, 4 May 2010 09:54:51 -0400
> Subject: [PATCH] regulator: use array in 88pm860x
> 
> Replace condition comparision statement by array. Clean code with simpler way.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but please try to make your changelogs include more high level
information - which comparisons are being replaced by an array, and in
what way is the code simpler?  Your changelog shouldn't just repeat
information that's in the diff.
