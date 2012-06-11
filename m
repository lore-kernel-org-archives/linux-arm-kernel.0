From: paulliu@debian.org (Ying-Chun Liu (PaulLiu))
Date: Mon, 11 Jun 2012 14:28:10 +0800
Subject: [PATCH RESEND] mfd: anatop: permit adata be NULL when access
 register
In-Reply-To: <20120611061925.GC2552@S2101-09.ap.freescale.net>
References: <1338774989-4416-1-git-send-email-richard.zhao@freescale.com>
 <20120604021315.GB2857@b20223-02.ap.freescale.net>
 <20120611061925.GC2552@S2101-09.ap.freescale.net>
Message-ID: <4FD58FFA.9020408@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2012?06?11? 14:19), Shawn Guo wrote:
> On Mon, Jun 04, 2012 at 10:13:16AM +0800, Richard Zhao wrote:
>> Cc Paul's other mail address.
>>
>> On Mon, Jun 04, 2012 at 09:56:29AM +0800, Richard Zhao wrote:
>>> From: Richard Zhao <richard.zhao@linaro.org>
>>>
>>> It makes anatop register access easier. Anatop has many misc registers,
>>> which may not be a specific driver.
>>>
>>> There's only one anatop device for a running system, so we use a global
>>> variable to store struct anatop.
>>>
>>> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
>>> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Ying-Chun Liu (PaulLiu) <paulliu@debian.org>

-- 
                                PaulLiu (???)
E-mail: Ying-Chun Liu (PaulLiu) <paulliu@debian.org>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 900 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120611/5170a3a9/attachment-0001.sig>
