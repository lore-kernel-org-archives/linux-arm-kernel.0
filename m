From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 13 Apr 2015 16:15:16 +0200
Subject: [PATCH v2 4/6] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <552BC207.40807@huawei.com>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
 <1428916660-25910-5-git-send-email-bintian.wang@huawei.com>
 <1428926202.11113.77.camel@x220> <552BC207.40807@huawei.com>
Message-ID: <1428934516.11113.82.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-04-13 at 21:17 +0800, Bintian wrote:
> Thank you very much for code review and testing on arm!

s/testing/crosscompiling for/

> On 2015/4/13 19:56, Paul Bolle wrote:
> > I wonder what checkpatch had to say about the length of the lines seen
> > in this patch.
> 
> Yes, I ran this script before sending out this patch set, it reports
> warnings about "line over 80 characters ", but I find it's easier to
> read than shrinking one line to several lines, so just keep it, do I
> need to fix it?

I'll leave that to the maintainers of drivers/clk/. (I don't care
deeply. So on second thought I should not have made that remark.)

Thanks,


Paul Bolle
