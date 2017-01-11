From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 11 Jan 2017 11:17:08 +0100
Subject: [PATCHv3 3/8] rtc: add STM32 RTC driver
In-Reply-To: <1feb3a23-7450-2b5c-9c1c-c7ecacd7fa17@st.com>
References: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
 <1483623809-29937-4-git-send-email-amelie.delaunay@st.com>
 <20170111000803.mlie6kizcsj2o7lh@piout.net>
 <1feb3a23-7450-2b5c-9c1c-c7ecacd7fa17@st.com>
Message-ID: <20170111101708.ujcgo7kpyywymyzp@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2017 at 11:07:16 +0100, Amelie DELAUNAY wrote :
> > This will never happen, tm is already checked multiple times (up to
> > three) in the core before this function can be called.
> > 
> You're right. I'll remove all rtc_valid_tm calls.

You can keep the one in read_time

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
