From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Apr 2012 21:20:25 -0700
Subject: [PATCH] ARM: fix mach-bcmring UART declarations
In-Reply-To: <4F8D7150.9060201@windriver.com>
References: <1334605108-28616-1-git-send-email-paul.gortmaker@windriver.com>
 <4F8C7617.5080902@broadcom.com> <4F8D7150.9060201@windriver.com>
Message-ID: <CAOesGMh8EA66uajVeauJj8vviATLEnNHODeNyyas0iC1vQjMww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 6:34 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On 12-04-16 03:42 PM, Jiandong Zheng wrote:
>> On 4/16/2012 12:38 PM, Paul Gortmaker wrote:
>>> This error appeared in the bcmring_defconfig build:
>
> [...]
>
>> This is already fixed by Olof Johansson.
>
> Thanks, I guess it just hasn't made it into linux-next yet.

Actually, I didn't fix the bus id case error, so I'll apply your
version. I could just fix up mine the same way, but git am -s is
quicker. :)


-Olof
