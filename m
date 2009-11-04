From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 4 Nov 2009 22:33:21 +0800
Subject: pxafb: RGBT555 support
In-Reply-To: <200911041105.34359.pieterg@gmx.com>
References: <200910291235.55826.pieterg@gmx.com>
	<200911041028.28859.pieterg@gmx.com>
	<f17812d70911040134r205f81a0v59cec86d355f2b55@mail.gmail.com>
	<200911041105.34359.pieterg@gmx.com>
Message-ID: <f17812d70911040633k27863332seaf29184ff38e7e7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Unfortunately, transparency is part of depth and it's really not easy to
>> distinguish between RGB565 and RGBT555 by depth and bits_per_pixel
>> only without introducing something else.
>
> So perhaps something like this (untested)?
>

This looks good to me - please have this tested and I'll merge it
later if no other comments.
