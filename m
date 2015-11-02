From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 2 Nov 2015 14:34:38 -0500
Subject: [PATCH] recordmcount: arm64: replace the ignored mcount call
 into nop
In-Reply-To: <20151102182836.GM29657@arm.com>
References: <1446019445-14421-1-git-send-email-huawei.libin@huawei.com>
 <201510292118.ZYBYzBGa%fengguang.wu@intel.com>
 <20151029150922.GE3440@arm.com> <5633077C.3050000@huawei.com>
 <20151102132608.59e16994@gandalf.local.home>
 <20151102182836.GM29657@arm.com>
Message-ID: <20151102143438.2022df5a@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Nov 2015 18:28:37 +0000
Will Deacon <will.deacon@arm.com> wrote:

> I see you're playing "chase the patches" at the moment ;)
> 

Why yes I am!

Trying to grab last minute patches from my INBOX (or they could be old
patches that I just missed), before kicking off my 12 hour test suite.

-- Steve
