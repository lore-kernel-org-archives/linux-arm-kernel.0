From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 24 May 2010 23:19:48 +0800
Subject: [RESEND PATCH] ARM: fix 'unannotated irqs-on' lockdep warning
In-Reply-To: <20100524144539.GE21117@n2100.arm.linux.org.uk>
References: <1274615328-27953-1-git-send-email-tom.leiming@gmail.com>
	<AANLkTikRp0EHxshKYq39p18ymoRNAtyHrNm3yq6A49-r@mail.gmail.com>
	<20100523141300.GD950@n2100.arm.linux.org.uk>
	<AANLkTinV9Na9zxYMIfTr893Ynnc0YOk2B6uPKEa9s4R1@mail.gmail.com>
	<20100523194746.GE950@n2100.arm.linux.org.uk>
	<20100524112355.18424622@tom-lei>
	<20100524071921.GA17528@n2100.arm.linux.org.uk>
	<20100524101416.GA21117@n2100.arm.linux.org.uk>
	<20100524222033.12b25f2a@tom-lei>
	<20100524144539.GE21117@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikGwEVtnGb5KdJb0GzWDpu-zk9bWwa3JAgwy1v3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> which needs to be redone with a little more understanding, like the
> following patch. ?Note: you will need the previous patch as well,
> which is separate because it addresses a *different* issue.

OK, the two patches do fix the 'unannotated irqs-on' lockdep warning.

Thanks,

-- 
Lei Ming
