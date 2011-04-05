From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Apr 2011 11:21:27 +0800
Subject: [PATCH] pxa2xx_spi: Fix race condition in stop_queue()
In-Reply-To: <201104042047.55504.anarsoul@gmail.com>
References: <1300055230-29628-1-git-send-email-anarsoul@gmail.com>
	<201104011303.59668.anarsoul@gmail.com>
	<BANLkTimBfLF_ef70dYsVDwKCU=fEe_+Z3w@mail.gmail.com>
	<201104042047.55504.anarsoul@gmail.com>
Message-ID: <BANLkTikZrjgjJBpeBoSHGzCshYrHQZ6hQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 5, 2011 at 1:47 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> On Monday 04 April 2011 20:35:14 Mike Frysinger wrote:
>
>> that's fine, i do. ?was this patch actually merged ? ?or is there a
>> new version on the way ?
>> -mike
>
> I suspect it's not merged yet. Btw, should I make a patch which fixes all
> drivers, or it's prefferable to make one patch per driver?
>

Please come up with one patch, Mike can help add a Tested-by then.
