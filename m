From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 21 Aug 2014 09:10:08 +0200
Subject: [PATCH v7 0/8] Per-user clock constraints
In-Reply-To: <20140821021200.GB11103@lunn.ch>
References: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
 <20140821021200.GB11103@lunn.ch>
Message-ID: <CAAObsKBUiNu-be2AvjedqoPrFNSTdcSA7nGg4PWisJR1Ry_gwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 August 2014 04:12, Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, Aug 18, 2014 at 05:30:26PM +0200, Tomeu Vizoso wrote:
>> Hi,
>>
>> in this v7 of the patchset I have only rebased on top of 3.17rc1, with no other
>> changes. I have had to do a fair amount of fixing due to the rebase, more
>> details below. Follows the original cover letter blurb:
>
> Hi Tomeu
>
> I would like to test this patchset, but patch 5 never made it to the
> list. Do you have a git tree i can clone?

Sure:

http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=clk-refactoring-7

Though it seems to have made into at least one mailing list (the
others seem to have rejected it because of either its size, or the
number of recipients):

http://article.gmane.org/gmane.linux.ports.ppc64.devel/104392

Thanks for the interest!

Tomeu

> Thanks
>         Andrew
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
