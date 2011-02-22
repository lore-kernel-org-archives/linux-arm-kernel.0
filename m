From: rabin@rab.in (Rabin Vincent)
Date: Tue, 22 Feb 2011 11:14:33 +0530
Subject: [linux-pm] [PATCHv2] amba: support pm ops
In-Reply-To: <201102212126.10742.rjw@sisk.pl>
References: <1297928986-31171-1-git-send-email-rabin.vincent@stericsson.com>
	<1298271737-1606-1-git-send-email-rabin.vincent@stericsson.com>
	<201102212126.10742.rjw@sisk.pl>
Message-ID: <AANLkTin75bnW69CDrKPkw+4K9sfAMLGPqYsV-UfHTASD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 01:56, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, February 21, 2011, Rabin Vincent wrote:
>> Support pm_ops in the AMBA bus, required to allow drivers to use runtime pm.
>> The implementation of AMBA bus pm ops is based on the platform bus
>> implementation.
>>
>> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks.

> (although I'd probably avoid creating an empty struct dev_pm_ops object
> if both CONFIG_HIBERNATION and CONFIG_SUSPEND are unset).

Done in v3.
