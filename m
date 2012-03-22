From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 22 Mar 2012 17:14:12 +0400
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <4F6AF845.9070209@metasoft.pl>
References: <4F683B36.8090101@metasoft.pl> <4F6A78ED.3050403@gmail.com>
 <4F6AF845.9070209@metasoft.pl>
Message-ID: <4F6B25A4.4090006@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-03-2012 14:00, Rafal Prylowski wrote:

>> I haven't looked through the patch yet, since I'm waiting on more
>> information from Mika and Hartley's testing.

>> However, the commit log doesn't tell me why we want this change. Is it a
>> performance improvement? If so, do you have some numbers that we can
>> paste into the commit log?

> In principle, using double buffering should be faster than using only
> one buffer and disabling/enabling channel each time. But my measurements
> doesn't show any significant change.

> The real reason for this change is that current code is not 100% reliable
> in IDE-DMA (I'm planning to submit ep93xx ide driver to linux-ide soon).

    IDE or libata driver? Asking because IDE drivers are not accepted anymore.

WBR, Sergei
