From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 21 Oct 2010 11:12:47 +0900
Subject: [PATCH 5/5] ARM: SAMSUNG: Add to enable/disable clock on S3C PL330
In-Reply-To: <AANLkTinYHSUP5AspWbzD8hfKJtEaFAfcUYC0sOPy+WKX@mail.gmail.com>
References: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
	<1287622713-1657-6-git-send-email-kgene.kim@samsung.com>
	<AANLkTi=ZTBuPBDL4MZ7MPn3Ha_cNhyShosyzn8q6QF3N@mail.gmail.com>
	<AANLkTimbHbO77POKuu=3XAO6Cq7UaAjJ291hwQqKTcNW@mail.gmail.com>
	<AANLkTinaDckVpJhadBcnhccdougyCG-FbXe23dh=_ep8@mail.gmail.com>
	<AANLkTinYHSUP5AspWbzD8hfKJtEaFAfcUYC0sOPy+WKX@mail.gmail.com>
Message-ID: <AANLkTi=qmEHozO+1YtySkcmvr=QP973JtanQogqT82b4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 10:54 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Thu, Oct 21, 2010 at 10:49 AM, Kyungmin Park <kmpark@infradead.org> wrote:
>>>> Can you make it REAL clock gating, enable clock only when using?
>>>
>>> Of course we can. But that will need some intrusive changes.
>>> Later, we'll implement that desirable feature.
>>> For now, many SoCs don't detect PL330 since the clocks are gated
>>> by default and we don't enable them in driver. So, this is just to get
>>> latest SoCs' PL330 working.
>>
>> I see even though I don't know "later" is how much
>
> We (apparently) don't have fixed policy about which devices have their clocks
> enabled by default and which don't.
> So, by default PL330 clock is enabled on some platforms and not on others.
> This patch only makes sure the PL330 works on all platforms at boot-time.
>
>
>> and include the s5pc210 code also at this patchset.
> Yes, all platforms should be enabled for PL330 driver.
BTW, what's the id of mdma and which clock at c210?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
