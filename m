From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Jun 2013 15:53:03 +0100
Subject: [PATCH] ARM: Add support for LPAE style CONTEXTIDR
In-Reply-To: <51C85A0D.3070400@codeaurora.org>
References: <1372080405-13365-1-git-send-email-cov@codeaurora.org>
 <20130624140424.GA24861@mudshark.cambridge.arm.com>
 <51C85A0D.3070400@codeaurora.org>
Message-ID: <20130624145303.GA25582@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 03:39:09PM +0100, Christopher Covington wrote:
> Hi Will,
> 
> On 06/24/2013 10:04 AM, Will Deacon wrote:
> [...]
> 
> > What's the advantage of this approach, other than you get an extra byte's
> > worth of PID?
> 
> In my view, the real advantage is that the the PID is located where people
> reading ARM Architecture Reference Manual are told they can find it.

Perhaps, but I'd usually expect a debugger or trace tools to do something
with the PID, and they likely expect it to be shifted, so you can't really
win.

Will
