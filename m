From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 26 Nov 2018 17:14:27 +0900
Subject: [PATCH 1/6] devfreq: add basic fileds supporting suspend
 functionality
In-Reply-To: <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
References: <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
 <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80@epcms1p8>
Message-ID: <20181126081427epcms1p8801d251017da40b59d7e8391ee247fdb@epcms1p8>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>The patch prepares devfreq device for handling suspend/resume functionality.
>The new fields will store needed information during this process.
>Devfreq framework handles opp-suspend DT entry and there is no need of
>modyfications in the drivers code.
>
>The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>solve issue with devfreq device's frequency during suspend/resume.
>During the discussion on LKML some corner cases and comments appeared
>related to the design. This patch address them keeping in mind suggestions
>from Chanwoo Choi.
>
>Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>

When you add new elements in a common struct (i.e., struct devfreq),
please describe kindly in the doxygen entries so that developers
may understand before reading all places where the new elements are
used.

You have added three new elements and there is no explanations on them.


Cheers,
MyungJoo
