From: ccross@android.com (Colin Cross)
Date: Mon, 6 Dec 2010 17:40:01 -0800
Subject: [PATCH] [2.6.37] ARM: tegra: fix regression from addruart rewrite
In-Reply-To: <20101207013632.GA9379@lixom.net>
References: <20101207013632.GA9379@lixom.net>
Message-ID: <AANLkTimAksepMCzuMzqTs53sUx8ErJxzJJZ8POHaqMJs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 6, 2010 at 5:36 PM, Olof Johansson <olof@lixom.net> wrote:
> 0ea1293009826da45e1019f45dfde1e557bb30df took out the test for
> MMU on/off but didn't switch the ldr instructions to no longer be
> conditionals based on said test.
>
> Fix that.

This is fixed in the uart macro consolidation patch I posted yesterday.
