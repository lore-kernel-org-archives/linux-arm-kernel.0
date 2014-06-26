From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Thu, 26 Jun 2014 03:15:33 +0000
Subject: [PATCH V2] ARM: imx: add cpufreq support for i.mx6sx
In-Reply-To: <CAOMZO5AzgcavwQMW=41eWJVBiZ+5onJWUyQWKwS4NJcvGA5OVw@mail.gmail.com>
References: <1403687412-22362-1-git-send-email-b20788@freescale.com>
 <CAOMZO5BDirj-5E0ha1iDzNSC1-+Exwo1QbZiP-7viDSpBqtEtQ@mail.gmail.com>
 <135a42da42024542b0f7a034ef1d63df@BY2PR03MB315.namprd03.prod.outlook.com>
 <CAOMZO5DOGgcZbD4zPhvaxerEHspSi4eQJhNsM=dxRVYCu6-e5w@mail.gmail.com>
 <CAOMZO5AzgcavwQMW=41eWJVBiZ+5onJWUyQWKwS4NJcvGA5OVw@mail.gmail.com>
Message-ID: <6eae47c611b94de097493d45bbd5992a@BY2PR03MB315.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maybe it is another issue? Do you see it on other platforms? As cpufreq function did work on SX. I will try other platform soon to see whether it is a new issue.

Best Regards.
Anson Huang
?
Freescale Semiconductor Shanghai
Tel:021-28937058


>-----Original Message-----
>From: Fabio Estevam [mailto:festevam at gmail.com]
>Sent: Thursday, June 26, 2014 11:12 AM
>To: Huang Yongcai-B20788
>Cc: Guo Shawn-R65073; Sascha Hauer; Russell King; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCH V2] ARM: imx: add cpufreq support for i.mx6sx
>
>On Thu, Jun 26, 2014 at 12:06 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Wed, Jun 25, 2014 at 11:53 PM, Anson.Huang at freescale.com
>> <Anson.Huang@freescale.com> wrote:
>>> Hi, Fabio
>>>         I have already sent cpufreq driver patch for review which is
>supporting i.MX6SX, you may need to add it by yourself if you want to test it,
>I attached the patch, hope it helps.
>>
>> Thanks. It works fine now.
>
>Forgot to mention that this error still appears:
>
>cpu cpu0: dev_pm_opp_get_opp_count: device OPP not found (-19)
