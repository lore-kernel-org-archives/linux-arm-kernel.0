From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 23:56:10 -0700
Subject: [PATCH 1/2] arm: prima2: pm: enable rtc alarm0 and alarm1 as
 wakeup source
In-Reply-To: <1375175273-14067-1-git-send-email-Baohua.Song@csr.com>
References: <1375175273-14067-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130814065610.GK19951@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 05:07:52PM +0800, Barry Song wrote:
> From: Xianglong Du <Xianglong.Du@csr.com>
> 
> this patch also enables RTC alarm as wakeup source after system suspends
> 
> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Please mind your punctuation (Capital letters and periods at ends of sentences)

Also, we tend to prefer ARM: as the prefix instead of arm:.

Fixed up the above, and applied the patch.


-Olof
