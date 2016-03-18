From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 18 Mar 2016 09:14:07 -0700
Subject: [PATCH 2/4] pinctrl: amlogic: Make driver independent from
 two-domain configuration
In-Reply-To: <CAOQ7t2YjS5nAb3xxpdH-H11+2Y8WeCkxdKJE9yUKzkbVYMYfEw@mail.gmail.com>
 (Carlo Caione's message of "Thu, 17 Mar 2016 19:15:24 +0100")
References: <1456869876-19320-1-git-send-email-carlo@caione.org>
 <1456869876-19320-3-git-send-email-carlo@caione.org>
 <CAOi56cWN-iPVh6Ace-SXUFoX4POnSyT0OmG8gyqivNpQTo9u4A@mail.gmail.com>
 <CAOQ7t2Ykgej4uyDLUvuSZyjiJwK1TF4RGYJQhXWubk69d1xA_Q@mail.gmail.com>
 <7h7fh1t8vu.fsf@baylibre.com>
 <CAOQ7t2YjS5nAb3xxpdH-H11+2Y8WeCkxdKJE9yUKzkbVYMYfEw@mail.gmail.com>
Message-ID: <7hzitvsr00.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carlo Caione <carlo@caione.org> writes:

> On Thu, Mar 17, 2016 at 4:35 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>
>> Do you have an ack now?  or are you still waiting?
>
> Still waiting for Rob.
>
>>> What's the fastest way to land the DTS changes in mainline at this point?
>>
>> When you've collected the acks, send a pull request through arm-soc so
>> we can get it in via our fixes branch.
>
> ok

If the Ack is not forthcoming ASAP, you should probably revert the
change so that mainline/arm-soc/linux-next are not broken.  For future
reference, it's better to wait until all dependencies can be merged
together.

Kevin
