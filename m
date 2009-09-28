From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 28 Sep 2009 13:37:50 +0200
Subject: [PATCH] Fix U300 generic GPIO, remove ifdefs from MMCI v2
In-Reply-To: <20090928112715.GB10671@n2100.arm.linux.org.uk>
References: <1254136780-31679-1-git-send-email-linus.walleij@stericsson.com>
	<20090928112715.GB10671@n2100.arm.linux.org.uk>
Message-ID: <63386a3d0909280437y437e0ccbo1e3180c1d5f196c8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/9/28 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Sep 28, 2009 at 01:19:40PM +0200, Linus Walleij wrote:
>> This version is hopefully correct for the API. Sorry for the mess
>> again and thanks to Russell and Rabin Vincent for pointing me
>> in the right direction on this one.
>
> I feel the comments in the code are too much. ?Maybe a single comment
> about the return value above the function would be sufficient?

OK there is a v3 redux version in the patch tracker with a single comment.
Thanks Russell!

Linus Walleij
