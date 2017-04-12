From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 13 Apr 2017 00:00:36 +0800
Subject: [PATCH 2/6] regulator: anatop: only set supply regulator when it
 actually exists
In-Reply-To: <20170412155336.vhhrftqmlxhti36n@sirena.org.uk>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
 <1491962327-12477-2-git-send-email-aisheng.dong@nxp.com>
 <20170411203124.y7cwyttqfu4a2aov@sirena.org.uk>
 <20170413071101.GA23163@b29396-OptiPlex-7040>
 <20170412155336.vhhrftqmlxhti36n@sirena.org.uk>
Message-ID: <CAA+hA=QG7xwJrX0q3fyTEAHEcwJr-0z0T+MvC2ESDpBGrhQVRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 11:53 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Apr 13, 2017 at 03:11:01PM +0800, Dong Aisheng wrote:
>
>> You're absolutely right!
>> I did this because there're some where else did the same thing.
>> e.g. drivers/regulator/fixed.c.
>
>> But it's obviously none of any platform specific and is perfectly
>> to be handled in regulator core.
>
> Did my patch solve the problems you were seeing?  I just wrote it
> quickly last thing before I finished for the evening.

It can solve the problem.
But it breaks some thing and need a further tiny fix.
I just replied the mail in your patch thread.
Please check it!

Regards
Dong Aisheng
