From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 14 Apr 2011 11:51:55 +0200
Subject: [RFC][PATCH V4] axi: add AXI bus driver
In-Reply-To: <BANLkTimcy16ggC0C66V-fbuaJwg4Sna4Qw@mail.gmail.com>
References: <1302634375-2378-1-git-send-email-zajec5@gmail.com>
	<20110413163113.GA24015@kroah.com>
	<BANLkTin-4HrJzNrLOxRy_-a98S3ZF4aSQw@mail.gmail.com>
	<1302726703.8015.1.camel@dev.znau.edu.ua>
	<BANLkTimwZOJ0a5kVfaUzEcsMc39H999u0A@mail.gmail.com>
	<1302727516.8015.9.camel@dev.znau.edu.ua>
	<BANLkTi=wzzzeF-PmqLt9o8arW7nRaFRRJw@mail.gmail.com>
	<1302729243.8479.1.camel@dev.znau.edu.ua>
	<BANLkTinLn4Ug=gX4coHJbSzrkxdSMjgGeg@mail.gmail.com>
	<BANLkTimcy16ggC0C66V-fbuaJwg4Sna4Qw@mail.gmail.com>
Message-ID: <BANLkTika3oprbxqYJTq=Fzms+LMdnxtwYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/14 Jonas Gorski <jonas.gorski@gmail.com>:
> On 13 April 2011 23:19, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>> 2011/4/13 George Kashperko <george@znau.edu.ua>:
>>>> I had no idea what you were referring to. We do not dig into PCIe
>>>> functions yet, so I believe for now we need this "if".
>>> You are already deep inside. Your host code drives pci function.
>>
>> But I don't use multiple PCIe functions, do not focus on that at all.
>
> I think what George meant is the following (please correct me if I
> understood you wrong) and has nothing to do with PCIe functions:
> <http://lxr.free-electrons.com/source/drivers/staging/brcm80211/util/aiutils.c#L522>

Ahh, thanks, I though PCIe functions are something different, that we
have to register for pci device differently to access them or sth.

-- 
Rafa?
