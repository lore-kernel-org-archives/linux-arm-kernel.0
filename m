From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 5 Mar 2013 11:21:54 -0300
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Enable touchscreen support
In-Reply-To: <20130305142059.GB26075@S2101-09.ap.freescale.net>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
 <20130304031716.GC30431@S2101-09.ap.freescale.net>
 <CAOMZO5BL5Y-N+-kJN83eh74ZU74qPwFujxzxALr3KAp4Z0XXtg@mail.gmail.com>
 <20130305142059.GB26075@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5AyL3fFSKBUAUY-p-x5rRtuA8La3ZbYhoQrECVyo57bAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 5, 2013 at 11:21 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Mar 05, 2013 at 11:07:55AM -0300, Fabio Estevam wrote:
>> On Mon, Mar 4, 2013 at 12:17 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>>
>> > I do not understand why.  But it seems to me that applying the patch on
>> > top of v3.9-rc1 results in a silent audio playback on my imx28-evk
>> > board.  Can you confirm that on your side?
>>
>> Just tested and I confirm I see the same issue here on 3.9-rc1.
>>
> Ok, I drop both patches for now.

Reverting ad76fda7 fixes the issue. Will send a patch shortly.
