From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 18 Apr 2012 13:49:38 -0700
Subject: [PATCH 00/13] SPEAr: Move to common clock framework
In-Reply-To: <20120417145745.GB6024@S2101-09.ap.freescale.net>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <201204171434.06178.arnd@arndb.de>
 <20120417145745.GB6024@S2101-09.ap.freescale.net>
Message-ID: <CAJOA=zNmBctsN3b9Lu4JeFa_eX_pdhQCmPgZv0WuLr5q0kvEew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 7:57 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Apr 17, 2012 at 02:34:05PM +0000, Arnd Bergmann wrote:
>> I wonder: should the clock drivers remain part of the platform directory,
>> or get moved into a subdirectory of drivers/clk? I was assuming that
>> we'd do the latter, but I haven't been following the clk discussions
>> that closely.
>>
> Mike had some comment [1] there, and I would second that.

Thanks for bringing up that thread Shawn.  Just to clarify, I don't
oppose platform clock code living in drivers/clk/.  If it can be done
easily then I'm all for it.

I do oppose any _requirement_ for clock code to live there.  That
would be unreasonable for complex hardware.

For anyone planning on pushing their platform clock code into
drivers/clk/ I would encourage them to think long and hard on the best
ways to make that code useful to others.

Regards,
Mike

> Regards,
> Shawn
>
> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/158320/focus=158543
