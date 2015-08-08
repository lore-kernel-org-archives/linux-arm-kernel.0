From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sat, 08 Aug 2015 15:51:54 +0300
Subject: [PATCH 0/8] misc: remove boundary checks from bin attr users
In-Reply-To: <20150807223456.GA1527@katana>
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
 <20150807161055.GD25357@katana> <55C4D9B2.3000708@mleia.com>
 <20150807223456.GA1527@katana>
Message-ID: <55C5FB6A.5010300@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On 08.08.2015 01:34, Wolfram Sang wrote:
> 
>> if we're talking about this particular series, you should have them in
>> your mailbox, since you have them applied in wsa/i2c/for-next:
> 
> Those are already in linus tree. I mean all drivers which use struct
> i2c_driver. Or do you prefer they go via Greg? I am fine with both.
> 

I think you may find most of the changes applied by Greg into
misc/char-misc-next branch.

The only change from the series, which is not found in
misc/char-misc-next or i2c/for-next is related to at25 driver (IC is
sitting on SPI):

  https://lkml.org/lkml/2015/7/26/101

Change 8/8 for sunxi is outdated due to accepted NVMEM framework.

With best wishes,
Vladimir
