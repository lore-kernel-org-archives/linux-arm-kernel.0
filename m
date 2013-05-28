From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 28 May 2013 17:58:08 +0200
Subject: [PATCH 00/10] clk: mvebu: restructure SoC clock drivers
In-Reply-To: <20130528175343.77c6353d@skate>
References: <1368234490-31416-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130528154047.GT31290@titan.lakedaemon.net> <20130528175343.77c6353d@skate>
Message-ID: <51A4D410.6030307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/13 17:53, Thomas Petazzoni wrote:
> On Tue, 28 May 2013 11:40:47 -0400, Jason Cooper wrote:
>> I'm posting the revised version as replies to patches 1, 5 and 6. Please
>> let me know if I messed it up.  I'd like to send the PR for these
>> shortly.
>
> I had a quick look, and it looks good to me. Let me know to which
> branch you've pushed this, and the merge order to follow to "rebuild"
> something that works, and I'll try to find some time to test it for
> real on hardware.

I also had a visual check of the files, especially clock_gating_descr.
Didn't find a typo. I will also compile and run on Dove and Kirkwood,
but I guess it should be fine.

Thanks for the effort!

Sebastian
