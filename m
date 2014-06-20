From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Jun 2014 09:25:56 +0100
Subject: [PATCH] arm64: add the ability to hook the fault code
In-Reply-To: <1403175296-25181-1-git-send-email-zhangwm@marvell.com>
References: <1403175296-25181-1-git-send-email-zhangwm@marvell.com>
Message-ID: <20140620082556.GD25104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 11:54:56AM +0100, Neil Zhang wrote:
> Add the ability to hook the fault code for future use.

Do you have a user for this in the kernel tree? I'd rather add the hook with
the first user, if it doesn't exist already.

Will
