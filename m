From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 21 Sep 2011 21:28:48 +0200
Subject: [PATCH 3/3] ARM: gic: add OF based initialization
In-Reply-To: <4E7A252F.2000402@gmail.com>
References: <1316550244-3655-1-git-send-email-robherring2@gmail.com>
	<1316550244-3655-4-git-send-email-robherring2@gmail.com>
	<4E7A1BCA.1090006@ti.com> <4E7A252F.2000402@gmail.com>
Message-ID: <4E7A3AF0.1020809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/21/2011 7:55 PM, Rob Herring wrote:

[...]

> I fixed that in the prior series and tglx picked it up, so I did not
> repost. It should hit mainline for 3.1, but I haven't verified if it is
> in yet. Sorry for the confusion, I should have mentioned that.

OK, I remember now as well that Thomas took patched 2 patches from your 
previous one. And I found it:
https://lkml.org/lkml/2011/9/14/190

Now, I have to find why the twl interrupt-controller is not working 
anymore even with that fix.

Almost-Tested-by: Benoit Cousson <b-cousson@ti.com>

Thanks,
Benoit
