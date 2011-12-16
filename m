From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 16 Dec 2011 21:39:38 +0530
Subject: [QUESTION] How to set static/dynamic dependency between clock
 domains
In-Reply-To: <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
 <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
Message-ID: <CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 9:27 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Hi,
>
> On Fri, Dec 16, 2011 at 9:24 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>
>> Also I have tried to add 'l3_2_clkdm' into dependency table of iss_clkdm in [2],
>> and it doesn't work.
>
> Also, I still have the question why the static dependency isn't generated from
> the table .wkdep_srcs of struct clockdomain? Seems the static dep info has been
> put inside the tables.
>
No. The table reflects the actual possible combination on hardware. You can't
add anything there arbitrary if that combination is not supported.

But that makes me wonder how the patch worked. I will look at this in detail
next week.

Regards
Santosh
