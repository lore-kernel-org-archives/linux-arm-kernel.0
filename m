From: kaloz@openwrt.org (Imre Kaloz)
Date: Sun, 04 Sep 2011 16:03:49 +0200
Subject: [PATCH] ARM: remove missing cns3xxx includes
In-Reply-To: <4E638210.1070202@ru.mvista.com>
References: <1314967815-32377-1-git-send-email-kaloz@openwrt.org>
	<4E638210.1070202@ru.mvista.com>
Message-ID: <op.v1aeony12s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, 04 Sep 2011 15:50:08 +0200, Sergei Shtylyov <sshtylyov@mvista.com> wrote:

> On 02-09-2011 16:50, Imre Kaloz wrote:
>
>> Commit c9d95fbe59e426eed7f16e7cac812e46ac4772d0 deleted cns3xxx' hardware.h,
>
>     Please also specify that commit's summary in parens.
>
>> but didn't remove references for it, so do it now.
>

Okay, I'll change the comment and resubmit.


Imre
