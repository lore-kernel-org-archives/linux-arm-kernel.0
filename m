From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 18 Feb 2014 14:11:58 +0800
Subject: [PATCH v3] input: sirfsoc-onkey - report onkey untouch event by
 detecting pin status
In-Reply-To: <20140217191658.GA19223@core.coreip.homeip.net>
References: <1392348001-4950-1-git-send-email-21cnbao@gmail.com>
 <20140214075717.GA14682@core.coreip.homeip.net>
 <CAGsJ_4xqnZAO6vpkgTEHmfp9+nbWa1qwQ4pda6B2sSrEtbV3ZA@mail.gmail.com>
 <847BC5012124A94BB5CA1B26E022CCA3012BAFDC27@SHAASIEXM01.ASIA.ROOT.PRI>
 <CAGsJ_4zjtWV3Z1AJ2bqekXn54rm=k8d4iOi_zzainCEnNGefCw@mail.gmail.com>
 <20140217191658.GA19223@core.coreip.homeip.net>
Message-ID: <CAGsJ_4yqAz6eVM0stvzstiC+rxuCK5G-0QM=F2NJWEviYJDD9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-02-18 3:16 GMT+08:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Fri, Feb 14, 2014 at 09:41:06PM +0800, Barry Song wrote:
>> >> Input: sirfsoc-onkey - implement open and close methods
>> >>
>> >> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> >>
>> >> We can control whetehr device generates interrupts or not so let's
>> >> implement open and close methods of input device so that we do not do any
>> >> processing until there are users.
>> >>
>> >> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> Tested-by: Xianglong Du <Xianglong.Du@csr.com>
>>
>> Dmitry, will you push this one to your tree so that i can rebase others?
>
> I rebased and pushed everything out, please take a look to make sure it
> all looks good.

thanks, we have done a update to CSR local tree.

>
> Thanks.
>
> --
> Dmitry

-barry
