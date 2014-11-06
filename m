From: s-anna@ti.com (Suman Anna)
Date: Thu, 6 Nov 2014 12:24:11 -0600
Subject: [PATCHv4 4/7] hwspinlock/core: add common OF helpers
In-Reply-To: <CAK=WgbYf3++K4MVXW_n4zj-8fMEee61XG5+r40cW=trapRtJ7w@mail.gmail.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <1389658764-39199-5-git-send-email-s-anna@ti.com>
 <CAJAp7Oj-3ZxvN8o=rg8YeTiXYWyQ1iowgisdU1R5UcZeh4VmOQ@mail.gmail.com>
 <5425938C.6070007@ti.com>
 <CAK=WgbYf3++K4MVXW_n4zj-8fMEee61XG5+r40cW=trapRtJ7w@mail.gmail.com>
Message-ID: <545BBCCB.7030107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On 10/06/2014 04:44 AM, Ohad Ben-Cohen wrote:
> On Fri, Sep 26, 2014 at 7:25 PM, Suman Anna <s-anna@ti.com> wrote:
>> I am yet to receive any comments on v6, but that series should address
>> both your need for a probe deferral and Ohad's request to not change any
>> return types. Please give it a try and let me know if you have any comments.
> 
> Guys,
> 
> Just to let you know we have several holidays around here these days,
> and I intend to review all pending patches immediately soon after.
> 

Ping on this. Can you review the latest series v6 [1] and pick it up for
3.19? The MSM spinlock driver is also blocked/dependent on that series.

regards
Suman

[1] http://marc.info/?l=linux-arm-kernel&m=141055365513902&w=2
