From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 19 May 2015 07:09:45 +0200
Subject: [PATCH soc] ARM: BCM5301X: Ignore another (BCM4709 specific)
 fault code
In-Reply-To: <55282985.6070009@gmail.com>
References: <1423669258-27449-1-git-send-email-zajec5@gmail.com>
 <55282985.6070009@gmail.com>
Message-ID: <CACna6rwMmm4wNaCRhi1dHCh8KwXt+-XuAejb4CuhkELhJ2=V4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2015 at 21:50, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 11/02/15 07:40, Rafa? Mi?ecki wrote:
>> Broadcom ARM devices seem to generate some fault once per boot. We
>> already have an ignoring handler for BCM4707/BCM4708, but BCM4709
>> generates different code.
>>
>> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
>
> Applied to platform/next, sorry for the lag, thanks!

Could you send a pull request for platform/next, please?

-- 
Rafa?
