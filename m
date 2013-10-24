From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 24 Oct 2013 17:45:38 +0100
Subject: [PATCH v3 0/3] MCPM/TC2 support for CPU powerdown synchronisation
In-Reply-To: <CALicx6uAPM8x_BcqUWtrSAMPOmc=EGMiwMKFtxL=7sUMo7BmqA@mail.gmail.com>
References: <CALicx6v86NMp53+zbE=A3ang-ftGE3KiUojkRZO4ss6Pmks1ow@mail.gmail.com>	<CALicx6tUgu=OnrBo1NaUHQz=hd7zHrXNbDmUGKPj6EnnXRQWTw@mail.gmail.com>
 <CALicx6uAPM8x_BcqUWtrSAMPOmc=EGMiwMKFtxL=7sUMo7BmqA@mail.gmail.com>
Message-ID: <52694EB2.1060701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/10/13 13:49, Vijay Kilari wrote:
> Sorry. Below is the right DCC configuration for SCC 700
> SCC: 0x700 0x0032F003           ;CFGRW48 - [25:24]Boot CPU [28]Boot
> 
> On Thu, Oct 24, 2013 at 6:18 PM, Vijay Kilari <vijay.kilari@gmail.com> wrote:
>> Hi Dave Martin,
>>
>>    With the below configuration, I tried to check cpu hotplug as this
>> is prerequisite for kexec.
>> I see cpu hotplug fails. hot-unplug is OK but hot plug-in fails.
>>
It works fine for me on v3.12-rc6.
Do you see any error message ?
(check demsg if loglevel is changed by some scripts in FS)

Regards,
Sudeep
