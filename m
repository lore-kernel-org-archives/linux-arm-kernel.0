From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 22 Sep 2009 15:45:47 +0200
Subject: [PATCH 3/3] Move MMCI header to amba include dir
In-Reply-To: <20090921151107.GC30821@n2100.arm.linux.org.uk>
References: <1252529727-7957-1-git-send-email-linus.walleij@stericsson.com>
	<20090921150103.GB30821@n2100.arm.linux.org.uk>
	<20090921151107.GC30821@n2100.arm.linux.org.uk>
Message-ID: <63386a3d0909220645t2f995c4ftf9893e23ac5caf0e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/9/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:

>> Not sure what's happened, but this patch appears to conflict with
>> another, resulting in:
>
> It's also meant that 5702/1 has been dropped in addition to 5699/1.
> In future, please ensure that you run a build check on the machines
> which you've modified. ?Thanks.

My fault for not regression-compiling enough. Learnt a lesson,
hotted my integration scripts with defaultcompiles for Realview,
Integrator and versatile and submitted new versions to the patch
tracker, sorry for the inconvenience.

Yours.
Linus Walleij
