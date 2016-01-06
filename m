From: v1ron@mail.ru (Roman Volkov)
Date: Wed, 6 Jan 2016 18:30:38 +0300
Subject: [PATCH v3 0/3] clocksource/vt8500: Fix hangs in small delays
In-Reply-To: <568D2387.4060708@linaro.org>
References: <1451654683-2401-1-git-send-email-v1ron@mail.ru>
 <568D2387.4060708@linaro.org>
Message-ID: <20160106183038.7e600409@v1ron-s7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? Wed, 6 Jan 2016 15:24:07 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> ?????:

> On 01/01/2016 02:24 PM, Roman Volkov wrote:
> > From: Roman Volkov <rvolkov@v1ros.org>
> >
> > vt8500 hangs in nanosleep() function, starting from commit
> > c6eb3f70d4482806dc2d3e1e3c7736f497b1d418, making the system
> > unusable. Per investigation, looks like set_next_event() now
> > receives too small delta and fails with -ETIME.  
> 
> 
> Hi Roman,
> 
> I think the patch 1/3 should go as a fix for 4.4-rc7 and stable and
> the two other should go for the next version as they are improvements 
> regarding the current code.
> 

Hi Daniel,

I agree, -stable can live without the patches 2 an 3.

Regards,
Roman
